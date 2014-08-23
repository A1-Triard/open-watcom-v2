/****************************************************************************
*
*                            Open Watcom Project
*
*    Portions Copyright (c) 1983-2002 Sybase, Inc. All Rights Reserved.
*
*  ========================================================================
*
*    This file contains Original Code and/or Modifications of Original
*    Code as defined in and that are subject to the Sybase Open Watcom
*    Public License version 1.0 (the 'License'). You may not use this file
*    except in compliance with the License. BY USING THIS FILE YOU AGREE TO
*    ALL TERMS AND CONDITIONS OF THE LICENSE. A copy of the License is
*    provided with the Original Code and Modifications, and is also
*    available at www.sybase.com/developer/opensource.
*
*    The Original Code and all software distributed under the License are
*    distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
*    EXPRESS OR IMPLIED, AND SYBASE AND ALL CONTRIBUTORS HEREBY DISCLAIM
*    ALL SUCH WARRANTIES, INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF
*    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR
*    NON-INFRINGEMENT. Please see the License for the specific language
*    governing rights and limitations under the License.
*
*  ========================================================================
*
* Description:  WHEN YOU FIGURE OUT WHAT THIS FILE DOES, PLEASE
*               DESCRIBE IT HERE!
*
****************************************************************************/


#include "wdeglbl.h"
#include "wderesin.h"
#include "wdeobjid.h"
#include "wdefutil.h"
#include "wde_wres.h"
#include "wdemain.h"
#include "wdeoinfo.h"
#include "wdedefsz.h"
#include "wdedebug.h"
#include "wde_rc.h"
#include "wdesdup.h"
#include "wdecctl.h"
#include "wdefhdr.h"

/****************************************************************************/
/* type definitions                                                         */
/****************************************************************************/
typedef struct {
    FARPROC     dispatcher;
    OBJPTR      object_handle;
    OBJ_ID      object_id;
    OBJPTR      control;
} WdeHdrObject;

/****************************************************************************/
/* external function prototypes                                             */
/****************************************************************************/
WINEXPORT BOOL    CALLBACK WdeHdrDispatcher( ACTION, WdeHdrObject *, void *, void * );
WINEXPORT LRESULT CALLBACK WdeHdrSuperClassProc( HWND, UINT, WPARAM, LPARAM );

/****************************************************************************/
/* static function prototypes                                               */
/****************************************************************************/
static OBJPTR   WdeMakeHdr( OBJPTR, RECT *, OBJPTR, DialogStyle, char *, OBJ_ID );
static OBJPTR   WdeHCreate( OBJPTR, RECT *, OBJPTR, OBJ_ID, WdeDialogBoxControl * );
static BOOL     WdeHdrDestroy( WdeHdrObject *, BOOL *, void * );
static BOOL     WdeHdrValidateAction( WdeHdrObject *, ACTION *, void * );
static BOOL     WdeHdrCopyObject( WdeHdrObject *, WdeHdrObject **, WdeHdrObject * );
static BOOL     WdeHdrIdentify( WdeHdrObject *, OBJ_ID *, void * );
static BOOL     WdeHdrGetWndProc( WdeHdrObject *, WNDPROC *, void * );
static BOOL     WdeHdrGetWindowClass( WdeHdrObject *, char **, void * );
static BOOL     WdeHdrDefine( WdeHdrObject *, POINT *, void * );
static void     WdeHdrSetDefineInfo( WdeDefineObjectInfo *, HWND );
static void     WdeHdrGetDefineInfo( WdeDefineObjectInfo *, HWND );
static BOOL     WdeHdrDefineHook( HWND, UINT, WPARAM, LPARAM, DialogStyle );

/****************************************************************************/
/* static variables                                                         */
/****************************************************************************/
static HINSTANCE                WdeApplicationInstance;
static FARPROC                  WdeHdrDispatch;
static WdeDialogBoxControl      *WdeDefaultHdr = NULL;
static int                      WdeHdrWndExtra;
static WNDPROC                  WdeOriginalHdrProc;
//static WNDPROC                WdeHdrProc;

#define WWC_HEADER       WC_HEADER

static DISPATCH_ITEM WdeHdrActions[] = {
    { DESTROY,          (DISPATCH_RTN *)WdeHdrDestroy        },
    { COPY,             (DISPATCH_RTN *)WdeHdrCopyObject     },
    { VALIDATE_ACTION,  (DISPATCH_RTN *)WdeHdrValidateAction },
    { IDENTIFY,         (DISPATCH_RTN *)WdeHdrIdentify       },
    { GET_WINDOW_CLASS, (DISPATCH_RTN *)WdeHdrGetWindowClass },
    { DEFINE,           (DISPATCH_RTN *)WdeHdrDefine         },
    { GET_WND_PROC,     (DISPATCH_RTN *)WdeHdrGetWndProc     }
};

#define MAX_ACTIONS      (sizeof( WdeHdrActions ) / sizeof( DISPATCH_ITEM ))

WINEXPORT OBJPTR CALLBACK WdeHdrCreate( OBJPTR parent, RECT *obj_rect, OBJPTR handle )
{
    if( handle == NULL ) {
        return( WdeMakeHdr( parent, obj_rect, handle, 0, "", HEADER_OBJ ) );
    } else {
        return( WdeHCreate( parent, obj_rect, NULL, HEADER_OBJ,
                            (WdeDialogBoxControl *)handle ) );
    }
}

OBJPTR WdeMakeHdr( OBJPTR parent, RECT *obj_rect, OBJPTR handle,
                   DialogStyle style, char *text, OBJ_ID id )
{
    OBJPTR new;

    style |= WS_BORDER | WS_VISIBLE | WS_TABSTOP | WS_CHILD;

    SETCTL_STYLE( WdeDefaultHdr, style );
    SETCTL_TEXT( WdeDefaultHdr, ResStrToNameOrOrd( text ) );
    SETCTL_ID( WdeDefaultHdr, WdeGetNextControlID() );

    WdeChangeSizeToDefIfSmallRect( parent, id, obj_rect );

    new = WdeHCreate( parent, obj_rect, handle, id, WdeDefaultHdr );

    WRMemFree( GETCTL_TEXT( WdeDefaultHdr ) );
    SETCTL_TEXT( WdeDefaultHdr, NULL );

    return( new );
}

OBJPTR WdeHCreate( OBJPTR parent, RECT *obj_rect, OBJPTR handle,
                   OBJ_ID id, WdeDialogBoxControl *info )
{
    WdeHdrObject *new;

    WdeDebugCreate( "Hdr", parent, obj_rect, handle );

    if( parent == NULL ) {
        WdeWriteTrail( "WdeHdrCreate: Hdr has no parent!" );
        return( NULL );
    }

    new = (WdeHdrObject *)WRMemAlloc( sizeof( WdeHdrObject ) );
    if( new == NULL ) {
        WdeWriteTrail( "WdeHdrCreate: Object malloc failed" );
        return( NULL );
    }

    new->dispatcher = WdeHdrDispatch;

    new->object_id = id;

    if( handle == NULL ) {
        new->object_handle = new;
    } else {
        new->object_handle = handle;
    }

    new->control = Create( CONTROL_OBJ, parent, obj_rect, new->object_handle );

    if( new->control == NULL ) {
        WdeWriteTrail( "WdeHdrCreate: CONTROL_OBJ not created!" );
        WRMemFree( new );
        return( NULL );
    }

    if( !Forward( (OBJPTR)new->object_handle, SET_OBJECT_INFO, info, NULL ) ) {
        WdeWriteTrail( "WdeHdrCreate: SET_OBJECT_INFO failed!" );
        Destroy( new->control, FALSE );
        WRMemFree( new );
        return( NULL );
    }

    if( !Forward( (OBJPTR)new->object_handle, CREATE_WINDOW, NULL, NULL ) ) {
        WdeWriteTrail( "WdeHdrCreate: CREATE_WINDOW failed!" );
        Destroy( new->control, FALSE );
        WRMemFree( new );
        return( NULL );
    }

    return( new );
}

WINEXPORT BOOL CALLBACK WdeHdrDispatcher( ACTION act, WdeHdrObject *obj, void *p1, void *p2 )
{
    int     i;

    WdeDebugDispatch( "Hdr", act, obj, p1, p2 );

    for( i = 0; i < MAX_ACTIONS; i++ ) {
        if( WdeHdrActions[i].id == act ) {
            return( WdeHdrActions[i].rtn( obj, p1, p2 ) );
        }
    }

    return( Forward( (OBJPTR)obj->control, act, p1, p2 ) );
}

bool WdeHdrInit( bool first )
{
    WNDCLASS    wc;

    WdeApplicationInstance = WdeGetAppInstance();
    GetClassInfo( (HINSTANCE)NULL, WWC_HEADER, &wc );
    WdeOriginalHdrProc = wc.lpfnWndProc;
    WdeHdrWndExtra = wc.cbWndExtra;

    if( first ) {
#if 0
        if( wc.style & CS_GLOBALCLASS ) {
            wc.style ^= CS_GLOBALCLASS;
        }
        if( wc.style & CS_PARENTDC ) {
            wc.style ^= CS_PARENTDC;
        }
        wc.style |= CS_HREDRAW | CS_VREDRAW;
        wc.hInstance = WdeApplicationInstance;
        wc.lpszClassName = "wdeedit";
        wc.cbWndExtra += sizeof( OBJPTR );
        //wc.lpfnWndProc = WdeHdrSuperClassProc;
        if( !RegisterClass( &wc ) ) {
            WdeWriteTrail( "WdeHdrInit: RegisterClass failed." );
        }
#endif
    }

    WdeDefaultHdr = WdeAllocDialogBoxControl ();
    if( WdeDefaultHdr == NULL ) {
        WdeWriteTrail( "WdeHdrInit: Alloc of control failed!" );
        return( FALSE );
    }

    /* set up the default control structure */
    SETCTL_STYLE( WdeDefaultHdr, WS_BORDER | WS_VISIBLE | WS_TABSTOP | WS_GROUP );
    SETCTL_ID( WdeDefaultHdr, 0 );
    SETCTL_EXTRABYTES( WdeDefaultHdr, 0 );
    SETCTL_SIZEX( WdeDefaultHdr, 0 );
    SETCTL_SIZEY( WdeDefaultHdr, 0 );
    SETCTL_SIZEW( WdeDefaultHdr, 0 );
    SETCTL_SIZEH( WdeDefaultHdr, 0 );
    SETCTL_TEXT( WdeDefaultHdr, NULL );
    SETCTL_CLASSID( WdeDefaultHdr, WdeStrToControlClass( WWC_HEADER ) );

    WdeHdrDispatch = MakeProcInstance( (FARPROC)WdeHdrDispatcher, WdeGetAppInstance() );
    return( TRUE );
}

void WdeHdrFini( void )
{
    WdeFreeDialogBoxControl( &WdeDefaultHdr );
    FreeProcInstance( WdeHdrDispatch );
}

BOOL WdeHdrDestroy( WdeHdrObject *obj, BOOL *flag, void *p2 )
{
    /* touch unused vars to get rid of warning */
    _wde_touch( p2 );

    if( !Forward( obj->control, DESTROY, flag, NULL ) ) {
        WdeWriteTrail( "WdeHdrDestroy: Control DESTROY failed" );
        return( FALSE );
    }

    WRMemFree( obj );

    return( TRUE );
}

BOOL WdeHdrValidateAction( WdeHdrObject *obj, ACTION *act, void *p2 )
{
    int     i;

    /* touch unused vars to get rid of warning */
    _wde_touch( p2 );

    for( i = 0; i < MAX_ACTIONS; i++ ) {
        if( WdeHdrActions[i].id == *act ) {
            return( TRUE );
        }
    }

    return( ValidateAction( (OBJPTR)obj->control, *act, p2 ) );
}

BOOL WdeHdrCopyObject( WdeHdrObject *obj, WdeHdrObject **new, WdeHdrObject *handle )
{
    if( new == NULL ) {
        WdeWriteTrail( "WdeHdrCopyObject: Invalid new object!" );
        return( FALSE );
    }

    *new = (WdeHdrObject *)WRMemAlloc( sizeof( WdeHdrObject ) );

    if( *new == NULL ) {
        WdeWriteTrail( "WdeHdrCopyObject: Object malloc failed" );
        return( FALSE );
    }

    (*new)->dispatcher = obj->dispatcher;
    (*new)->object_id = obj->object_id;

    if( handle == NULL ) {
        (*new)->object_handle = *new;
    } else {
        (*new)->object_handle = handle;
    }

    if( !CopyObject( obj->control, &(*new)->control, (*new)->object_handle ) ) {
        WdeWriteTrail( "WdeHdrCopyObject: Control not created!" );
        WRMemFree( *new );
        return( FALSE );
    }

    return( TRUE );
}

BOOL WdeHdrIdentify( WdeHdrObject *obj, OBJ_ID *id, void *p2 )
{
    /* touch unused vars to get rid of warning */
    _wde_touch( p2 );

    *id = obj->object_id;

    return( TRUE );
}

BOOL WdeHdrGetWndProc( WdeHdrObject *obj, WNDPROC *proc, void *p2 )
{
    /* touch unused vars to get rid of warning */
    _wde_touch( obj );
    _wde_touch( p2 );

    *proc = WdeHdrSuperClassProc;

    return( TRUE );
}

BOOL WdeHdrGetWindowClass( WdeHdrObject *obj, char **class, void *p2 )
{
    /* touch unused vars to get rid of warning */
    _wde_touch( obj );
    _wde_touch( p2 );

    *class = WWC_HEADER;

    return( TRUE );
}

BOOL WdeHdrDefine( WdeHdrObject *obj, POINT *pnt, void *p2 )
{
    WdeDefineObjectInfo  o_info;

    /* touch unused vars to get rid of warning */
    _wde_touch( pnt );
    _wde_touch( p2 );

    o_info.obj = obj->object_handle;
    o_info.obj_id = obj->object_id;
    o_info.mask = WS_VISIBLE | WS_DISABLED | WS_TABSTOP | WS_GROUP | WS_BORDER;
    o_info.set_func = (WdeSetProc)WdeHdrSetDefineInfo;
    o_info.get_func = (WdeGetProc)WdeHdrGetDefineInfo;
    o_info.hook_func = WdeHdrDefineHook;
    o_info.win = NULL;

    return( WdeControlDefine( &o_info ) );
}

void WdeHdrSetDefineInfo( WdeDefineObjectInfo *o_info, HWND hDlg )
{
#ifdef __NT__XX
    DialogStyle mask;

    // set the header control options
    mask = GETCTL_STYLE( o_info->info.c.info ) & 0x0000000f;
    if( mask & HDS_BUTTONS ) {
        CheckDlgButton( hDlg, IDB_HDS_BUTTONS, BST_CHECKED );
    }

    // set the extended style controls only
    WdeEXSetDefineInfo( o_info, hDlg );
#else
    _wde_touch( o_info );
    _wde_touch( hDlg );
#endif
}

void WdeHdrGetDefineInfo( WdeDefineObjectInfo *o_info, HWND hDlg )
{
#ifdef __NT__XX
    DialogStyle mask = 0;

    // get the header control styles
    if( IsDlgButtonChecked( hDlg, IDB_HDS_BUTTONS ) ) {
        mask |= HDS_BUTTONS;
    }
    SETCTL_STYLE( o_info->info.c.info,
                  (GETCTL_STYLE( o_info->info.c.info ) & 0xfffffff0) | mask );

    // get the extended control settings
    WdeEXGetDefineInfo( o_info, hDlg );
#else
    _wde_touch( o_info );
    _wde_touch( hDlg );
#endif
}

BOOL WdeHdrDefineHook( HWND hDlg, UINT message,
                       WPARAM wParam, LPARAM lParam, DialogStyle mask )
{
    BOOL processed;

    /* touch unused vars to get rid of warning */
    _wde_touch( hDlg );
    _wde_touch( message );
    _wde_touch( wParam );
    _wde_touch( lParam );
    _wde_touch( mask );

    processed = FALSE;

    return( processed );
}

WINEXPORT LRESULT CALLBACK WdeHdrSuperClassProc( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam )
{
    if( !WdeProcessMouse( hWnd, message, wParam, lParam ) ) {
        return( CallWindowProc( WdeOriginalHdrProc, hWnd, message, wParam, lParam ) );
    }
    return( FALSE );
}
