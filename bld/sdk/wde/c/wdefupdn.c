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
#include "wdefupdn.h"

/****************************************************************************/
/* type definitions                                                         */
/****************************************************************************/
typedef struct {
    FARPROC     dispatcher;
    OBJPTR      object_handle;
    OBJ_ID      object_id;
    OBJPTR      control;
} WdeUpDnObject;

/****************************************************************************/
/* external function prototypes                                             */
/****************************************************************************/
WINEXPORT BOOL    CALLBACK WdeUpDnDispatcher( ACTION, WdeUpDnObject *, void *, void * );
WINEXPORT LRESULT CALLBACK WdeUpDnSuperClassProc( HWND, UINT, WPARAM, LPARAM );

/****************************************************************************/
/* static function prototypes                                               */
/****************************************************************************/
static OBJPTR   WdeMakeUpDn( OBJPTR, RECT *, OBJPTR, DialogStyle, char *, OBJ_ID );
static OBJPTR   WdeUDCreate( OBJPTR, RECT *, OBJPTR, OBJ_ID, WdeDialogBoxControl * );
static void     WdeUpDnSetDefineInfo( WdeDefineObjectInfo *, HWND );
static void     WdeUpDnGetDefineInfo( WdeDefineObjectInfo *, HWND );
static bool     WdeUpDnDefineHook( HWND, UINT, WPARAM, LPARAM, DialogStyle );

#define pick(e,n,c) BOOL WdeUpDn ## n ## c
static pick_ACT_DESTROY( WdeUpDnObject );
static pick_ACT_COPY( WdeUpDnObject );
static pick_ACT_VALIDATE_ACTION( WdeUpDnObject );
static pick_ACT_IDENTIFY( WdeUpDnObject );
static pick_ACT_GET_WINDOW_CLASS( WdeUpDnObject );
static pick_ACT_DEFINE( WdeUpDnObject );
static pick_ACT_GET_WND_PROC( WdeUpDnObject );
#undef pick

/****************************************************************************/
/* static variables                                                         */
/****************************************************************************/
static HINSTANCE                WdeApplicationInstance;
static FARPROC                  WdeUpDnDispatch;
static WdeDialogBoxControl      *WdeDefaultUpDn = NULL;
static int                      WdeUpDnWndExtra;
static WNDPROC                  WdeOriginalUpDnProc;
//static WNDPROC                WdeUpDnProc;

#define WUPDOWN_CLASS    UPDOWN_CLASS

static DISPATCH_ITEM WdeUpDnActions[] = {
    #define pick(e,n,c) {e, (DISPATCH_RTN *)WdeUpDn ## n},
    pick_ACT_DESTROY( WdeUpDnObject )
    pick_ACT_COPY( WdeUpDnObject )
    pick_ACT_VALIDATE_ACTION( WdeUpDnObject )
    pick_ACT_IDENTIFY( WdeUpDnObject )
    pick_ACT_GET_WINDOW_CLASS( WdeUpDnObject )
    pick_ACT_DEFINE( WdeUpDnObject )
    pick_ACT_GET_WND_PROC( WdeUpDnObject )
    #undef pick
};

#define MAX_ACTIONS     (sizeof( WdeUpDnActions ) / sizeof( DISPATCH_ITEM ))

WINEXPORT OBJPTR CALLBACK WdeUpDnCreate( OBJPTR parent, RECT *obj_rect, OBJPTR handle )
{
    if( handle == NULL ) {
        return( WdeMakeUpDn( parent, obj_rect, handle, 0, "", UPDOWN_OBJ ) );
    } else {
        return( WdeUDCreate( parent, obj_rect, NULL, UPDOWN_OBJ,
                             (WdeDialogBoxControl *)handle ) );
    }
}

OBJPTR WdeMakeUpDn( OBJPTR parent, RECT *obj_rect, OBJPTR handle,
                    DialogStyle style, char *text, OBJ_ID id )
{
    OBJPTR new;

    style |= WS_BORDER | WS_VISIBLE | WS_TABSTOP | WS_CHILD;

    SETCTL_STYLE( WdeDefaultUpDn, style );
    SETCTL_TEXT( WdeDefaultUpDn, ResStrToNameOrOrd( text ) );
    SETCTL_ID( WdeDefaultUpDn, WdeGetNextControlID() );

    WdeChangeSizeToDefIfSmallRect( parent, id, obj_rect );

    new = WdeUDCreate( parent, obj_rect, handle, id, WdeDefaultUpDn );

    WRMemFree( GETCTL_TEXT( WdeDefaultUpDn ) );
    SETCTL_TEXT( WdeDefaultUpDn, NULL );

    return( new );
}

OBJPTR WdeUDCreate( OBJPTR parent, RECT *obj_rect, OBJPTR handle,
                    OBJ_ID id, WdeDialogBoxControl *info )
{
    WdeUpDnObject *new;

    WdeDebugCreate( "UpDn", parent, obj_rect, handle );

    if( parent == NULL ) {
        WdeWriteTrail( "WdeUpDnCreate: UpDn has no parent!" );
        return( NULL );
    }

    new = (WdeUpDnObject *)WRMemAlloc( sizeof( WdeUpDnObject ) );
    if( new == NULL ) {
        WdeWriteTrail( "WdeUpDnCreate: Object malloc failed" );
        return( NULL );
    }

    new->dispatcher = WdeUpDnDispatch;
    new->object_id = id;
    if( handle == NULL ) {
        new->object_handle = new;
    } else {
        new->object_handle = handle;
    }

    new->control = Create( CONTROL_OBJ, parent, obj_rect, new->object_handle );

    if( new->control == NULL ) {
        WdeWriteTrail( "WdeUpDnCreate: CONTROL_OBJ not created!" );
        WRMemFree( new );
        return( NULL );
    }

    if( !Forward( (OBJPTR)new->object_handle, SET_OBJECT_INFO, info, NULL ) ) {
        WdeWriteTrail( "WdeUpDnCreate: SET_OBJECT_INFO failed!" );
        Destroy( new->control, false );
        WRMemFree( new );
        return( NULL );
    }

    if( !Forward( (OBJPTR)new->object_handle, CREATE_WINDOW, NULL, NULL ) ) {
        WdeWriteTrail( "WdeUpDnCreate: CREATE_WINDOW failed!" );
        Destroy( new->control, false );
        WRMemFree( new );
        return( NULL );
    }

    return( new );
}

WINEXPORT BOOL CALLBACK WdeUpDnDispatcher( ACTION act, WdeUpDnObject *obj, void *p1, void *p2 )
{
    int     i;

    WdeDebugDispatch( "UpDn", act, obj, p1, p2 );

    for( i = 0; i < MAX_ACTIONS; i++ ) {
        if( WdeUpDnActions[i].id == act ) {
            return( WdeUpDnActions[i].rtn( obj, p1, p2 ) );
        }
    }

    return( Forward( (OBJPTR)obj->control, act, p1, p2 ) );
}

bool WdeUpDnInit( bool first )
{
    WNDCLASS    wc;

    WdeApplicationInstance = WdeGetAppInstance();
    GetClassInfo( (HINSTANCE)NULL, WUPDOWN_CLASS, &wc );
    WdeOriginalUpDnProc = wc.lpfnWndProc;
    WdeUpDnWndExtra = wc.cbWndExtra;

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
        //wc.lpfnWndProc = WdeUpDnSuperClassProc;
        if( !RegisterClass( &wc ) ) {
            WdeWriteTrail( "WdeUpDnInit: RegisterClass failed." );
        }
#endif
    }

    WdeDefaultUpDn = WdeAllocDialogBoxControl();
    if( WdeDefaultUpDn == NULL ) {
        WdeWriteTrail( "WdeUpDnInit: Alloc of control failed!" );
        return( FALSE );
    }

    /* set up the default control structure */
    SETCTL_STYLE( WdeDefaultUpDn, WS_BORDER | WS_VISIBLE | WS_TABSTOP | WS_GROUP );
    SETCTL_ID( WdeDefaultUpDn, 0 );
    SETCTL_EXTRABYTES( WdeDefaultUpDn, 0 );
    SETCTL_SIZEX( WdeDefaultUpDn, 0 );
    SETCTL_SIZEY( WdeDefaultUpDn, 0 );
    SETCTL_SIZEW( WdeDefaultUpDn, 0 );
    SETCTL_SIZEH( WdeDefaultUpDn, 0 );
    SETCTL_TEXT( WdeDefaultUpDn, NULL );
    SETCTL_CLASSID( WdeDefaultUpDn, WdeStrToControlClass( WUPDOWN_CLASS ) );

    WdeUpDnDispatch = MakeProcInstance( (FARPROC)WdeUpDnDispatcher,
                                        WdeGetAppInstance() );
    return( TRUE );
}

void WdeUpDnFini( void )
{
    WdeFreeDialogBoxControl( &WdeDefaultUpDn );
    FreeProcInstance( WdeUpDnDispatch );
}

BOOL WdeUpDnDestroy( WdeUpDnObject *obj, bool *flag, bool *p2 )
{
    /* touch unused vars to get rid of warning */
    _wde_touch( p2 );

    if( !Forward( obj->control, DESTROY, flag, NULL ) ) {
        WdeWriteTrail( "WdeUpDnDestroy: Control DESTROY failed" );
        return( FALSE );
    }

    WRMemFree( obj );

    return( TRUE );
}

BOOL WdeUpDnValidateAction( WdeUpDnObject *obj, ACTION *act, void *p2 )
{
    int     i;

    /* touch unused vars to get rid of warning */
    _wde_touch( p2 );

    for( i = 0; i < MAX_ACTIONS; i++ ) {
        if( WdeUpDnActions[i].id == *act ) {
            return( TRUE );
        }
    }

    return( ValidateAction( (OBJPTR) obj->control, *act, p2 ) );
}

BOOL WdeUpDnCopyObject( WdeUpDnObject *obj, WdeUpDnObject **new, WdeUpDnObject *handle )
{
    if( new == NULL ) {
        WdeWriteTrail( "WdeUpDnCopyObject: Invalid new object!" );
        return( FALSE );
    }

    *new = (WdeUpDnObject *)WRMemAlloc( sizeof( WdeUpDnObject ) );

    if( *new == NULL ) {
        WdeWriteTrail( "WdeUpDnCopyObject: Object malloc failed" );
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
        WdeWriteTrail( "WdeUpDnCopyObject: Control not created!" );
        WRMemFree( *new );
        return( FALSE );
    }

    return( TRUE );
}

BOOL WdeUpDnIdentify( WdeUpDnObject *obj, OBJ_ID *id, void *p2 )
{
    /* touch unused vars to get rid of warning */
    _wde_touch( p2 );

    *id = obj->object_id;

    return( TRUE );
}

BOOL WdeUpDnGetWndProc( WdeUpDnObject *obj, WNDPROC *proc, void *p2 )
{
    /* touch unused vars to get rid of warning */
    _wde_touch( obj );
    _wde_touch( p2 );

    *proc = WdeUpDnSuperClassProc;

    return( TRUE );
}

BOOL WdeUpDnGetWindowClass( WdeUpDnObject *obj, char **class, void *p2 )
{
    /* touch unused vars to get rid of warning */
    _wde_touch( obj );
    _wde_touch( p2 );

    *class = WUPDOWN_CLASS;

    return( TRUE );
}

BOOL WdeUpDnDefine( WdeUpDnObject *obj, POINT *pnt, void *p2 )
{
    WdeDefineObjectInfo  o_info;

    /* touch unused vars to get rid of warning */
    _wde_touch( pnt );
    _wde_touch( p2 );

    o_info.obj = obj->object_handle;
    o_info.obj_id = obj->object_id;
    o_info.mask = WS_VISIBLE | WS_DISABLED | WS_TABSTOP | WS_GROUP | WS_BORDER;
    o_info.set_func = (WdeSetProc)WdeUpDnSetDefineInfo;
    o_info.get_func = (WdeGetProc)WdeUpDnGetDefineInfo;
    o_info.hook_func = WdeUpDnDefineHook;
    o_info.win = NULL;

    return( WdeControlDefine( &o_info ) );
}

void WdeUpDnSetDefineInfo( WdeDefineObjectInfo *o_info, HWND hDlg )
{
#ifdef __NT__XX
    DialogStyle mask;

    // set the up down control options
    mask = GETCTL_STYLE( o_info->info.c.info ) & 0x000000ff;
    if( mask & UDS_WRAP ) {
        CheckDlgButton( hDlg, IDB_UDS_WRAP, BST_CHECKED );
    }
    if( mask & UDS_SETBUDDYINT ) {
        CheckDlgButton( hDlg, IDB_UDS_SETBUDDYINT, BST_CHECKED );
    }
    if( mask & UDS_AUTOBUDDY ) {
        CheckDlgButton( hDlg, IDB_UDS_AUTOBUDDY, BST_CHECKED );
    }
    if( mask & UDS_ARROWKEYS ) {
        CheckDlgButton( hDlg, IDB_UDS_ARROWKEYS, BST_CHECKED );
    }
    if( mask & UDS_HORZ ) {
        CheckDlgButton( hDlg, IDB_UDS_HORZ, BST_CHECKED );
    }
    if( mask & UDS_NOTHOUSANDS ) {
        CheckDlgButton( hDlg, IDB_UDS_NOTHOUSANDS, BST_CHECKED );
    }
    if( mask & UDS_ALIGNRIGHT ) {
        CheckDlgButton( hDlg, IDB_UDS_ALIGNRIGHT, BST_CHECKED );
    } else {
        CheckDlgButton( hDlg, IDB_UDS_ALIGNLEFT, BST_CHECKED );
    }

    // set the extended style controls only
    WdeEXSetDefineInfo( o_info, hDlg );
#else
    _wde_touch( o_info );
    _wde_touch( hDlg );
#endif
}

void WdeUpDnGetDefineInfo( WdeDefineObjectInfo *o_info, HWND hDlg )
{
#ifdef __NT__XX
    DialogStyle mask = 0;

    // get the Up Down control settings
    if( IsDlgButtonChecked( hDlg, IDB_UDS_WRAP ) ) {
        mask |= UDS_WRAP;
    }
    if( IsDlgButtonChecked( hDlg, IDB_UDS_SETBUDDYINT ) ) {
        mask |= UDS_SETBUDDYINT;
    }
    if( IsDlgButtonChecked( hDlg, IDB_UDS_AUTOBUDDY ) ) {
        mask |= UDS_AUTOBUDDY;
    }
    if( IsDlgButtonChecked( hDlg, IDB_UDS_ARROWKEYS ) ) {
        mask |= UDS_ARROWKEYS;
    }
    if( IsDlgButtonChecked( hDlg, IDB_UDS_HORZ ) ) {
        mask |= UDS_HORZ;
    }
    if( IsDlgButtonChecked( hDlg, IDB_UDS_NOTHOUSANDS ) ) {
        mask |= UDS_NOTHOUSANDS;
    }
    if( IsDlgButtonChecked( hDlg, IDB_UDS_ALIGNRIGHT ) ) {
        mask |= UDS_ALIGNRIGHT;
    } else {
        mask |= UDS_ALIGNLEFT;
    }

    SETCTL_STYLE( o_info->info.c.info,
                  (GETCTL_STYLE( o_info->info.c.info ) & 0xffff0000) | mask );

    // get the extended control settings
    WdeEXGetDefineInfo( o_info, hDlg );
#else
    _wde_touch( o_info );
    _wde_touch( hDlg );
#endif
}

bool WdeUpDnDefineHook( HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam, DialogStyle mask )
{
    bool processed;

    /* touch unused vars to get rid of warning */
    _wde_touch( hDlg );
    _wde_touch( message );
    _wde_touch( wParam );
    _wde_touch( lParam );
    _wde_touch( mask );

    processed = false;

    return( processed );
}

WINEXPORT LRESULT CALLBACK WdeUpDnSuperClassProc( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam )
{
    if( !WdeProcessMouse( hWnd, message, wParam, lParam ) ) {
        return( CallWindowProc( WdeOriginalUpDnProc, hWnd, message, wParam, lParam ) );
    }
    return( FALSE );
}
