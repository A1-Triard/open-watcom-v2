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
#include <mbstring.h>
#include "wdemain.h"
#include "wderes.h"
#include "wdedebug.h"
#include "wdefutil.h"
#include "wdefbase.h"
#include "wdefont.h"
#include "wdemsgbx.h"
#include "rcstr.gh"
#include "wdeedit.h"
#include "wdectl3d.h"

/****************************************************************************/
/* external function prototypes                                             */
/****************************************************************************/
WINEXPORT LRESULT CALLBACK WdeEditWndProc( HWND, UINT, WPARAM, LPARAM );
WINEXPORT LRESULT CALLBACK WdeFormsWndProc( HWND, UINT, WPARAM, LPARAM );

/****************************************************************************/
/* static function prototypes                                               */
/****************************************************************************/

/****************************************************************************/
/* static variables                                                         */
/****************************************************************************/
static HFONT    WdeEditFont     = NULL;
static HBRUSH   WdeFormsBrush   = NULL;
static HBRUSH   WdeEditBrush    = NULL;

bool WdeSetEditMode( WdeResInfo *info, bool new_mode )
{
    bool old_mode;

    if( info != NULL ) {
        old_mode = info->editting;
        info->editting = new_mode;
    } else {
        old_mode = FALSE;
    }

    return( old_mode );
}

HWND WdeGetFormsWindowHandle( WdeResInfo *info )
{
    if( info != NULL ) {
        return( info->forms_win );
    } else {
        info = WdeGetCurrentRes();
        if( info != NULL ) {
            return( info->edit_win );
        } else {
            return( NULL );
        }
    }
}

HWND WdeGetEditWindowHandle( WdeResInfo *info )
{
    if( info != NULL ) {
        return( info->edit_win );
    } else {
        info = WdeGetCurrentRes();
        if( info ) {
            return( info->edit_win );
        } else {
            return( NULL );
        }
    }
}

void WdeInitEditClass( void )
{
    LOGBRUSH    lbrush;
    char        *text;
    char        *cp;
    int         point_size;
    bool        use_default;

    WdeEditBrush = GetStockObject( WHITE_BRUSH );

    /* create a transparent brush */
    memset( &lbrush, 0, sizeof( LOGBRUSH ) );
    lbrush.lbStyle = BS_HOLLOW;
    WdeFormsBrush = CreateBrushIndirect( &lbrush );

    if( WdeEditFont == NULL ) {
        use_default = TRUE;
        text = WdeAllocRCString( WDE_EDITWINDOWFONT );
        if( text != NULL ) {
            cp = (char *)_mbschr( (unsigned char const *)text, '.' );
            if( cp != NULL ) {
                *cp = '\0';
                cp++;
                point_size = atoi( cp );
                use_default = FALSE;
            }
        }

        if( use_default ) {
            WdeEditFont = WdeGetFont( "Helv", 8, FW_BOLD );
        } else {
            WdeEditFont = WdeGetFont( text, point_size, FW_BOLD );
        }

        if( text != NULL ) {
            WdeFreeRCString( text );
        }
    }
}

void WdeFiniEditClass( void )
{
    if( WdeEditFont != (HFONT)NULL ) {
        DeleteObject( WdeEditFont );
    }
    if( !WdeIsFirstInst() && WdeFormsBrush != (HBRUSH)NULL ) {
        DeleteObject( WdeFormsBrush );
    }
}

bool WdeRegisterEditClass( HINSTANCE app_inst )
{
    WNDCLASS wc;

    /* fill in the window class structure for the edit window */
    wc.style = CS_DBLCLKS | CS_VREDRAW | CS_HREDRAW;
    wc.lpfnWndProc = WdeEditWndProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = sizeof( LONG_PTR );
    wc.hInstance = app_inst;
    wc.hIcon = NULL;
    wc.hCursor = NULL;
    wc.hbrBackground = WdeEditBrush;
    wc.lpszMenuName = NULL;
    wc.lpszClassName = "WdeEditClass";

    /* register the edit window class */
    if( !RegisterClass( &wc ) ) {
        WdeDisplayErrorMsg( WDE_EDITREGISTERCLASSFAILED );
        return( FALSE );
    }

    /* fill in the window class structure for the edit window */
    wc.style = CS_DBLCLKS | CS_VREDRAW | CS_HREDRAW;
    wc.lpfnWndProc = WdeFormsWndProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = sizeof( LONG_PTR );
    wc.hInstance = app_inst;
    wc.hIcon = NULL;
    wc.hCursor = NULL;
    wc.hbrBackground = WdeFormsBrush;
    wc.lpszMenuName = NULL;
    wc.lpszClassName = "WdeFormsClass";

    /* register the edit window class */
    if( !RegisterClass( &wc ) ) {
        WdeDisplayErrorMsg( WDE_EDITREGISTERCLASSFAILED );
        return( FALSE );
    }

    return( TRUE );
}

void WdeDestroyEditWindows( WdeResInfo *info )
{
    HWND win;

    if( info != NULL ) {
        if( info->edit_win != NULL ) {
            win = info->edit_win;
            info->edit_win = NULL;
            DestroyWindow( win );
        }

        if( info->forms_win != NULL ) {
            win = info->forms_win;
            info->forms_win = NULL;
            DestroyWindow( win );
        }
    }
}

bool WdeCreateEditWindows( WdeResInfo *info )
{
    RECT      rect;
    HINSTANCE app_inst;

    if( info == NULL || info->res_win == NULL ) {
        return( FALSE );
    }

    app_inst = WdeGetAppInstance();

    GetClientRect( info->res_win, &rect );

    info->forms_win = CreateWindow( "WdeFormsClass", NULL, WS_CHILD | WS_VISIBLE,
                                    0, 0, rect.right - rect.left, rect.bottom - rect.top,
                                    info->res_win, (HMENU)NULL, app_inst, NULL );

    if( info->forms_win == NULL ) {
        WdeWriteTrail( "WdeCreateEditWindow: failed to create forms window!" );
        return( FALSE );
    }

    GetClientRect( info->forms_win, &rect );

    info->edit_win = CreateWindow( "WdeEditClass", NULL, WS_CHILD | WS_VISIBLE, 0, 0,
                                   rect.right - rect.left, rect.bottom - rect.top,
                                   info->res_win, (HMENU)NULL, app_inst, NULL );

    if( info->edit_win == NULL ) {
        WdeWriteTrail( "WdeCreateEditWindow: failed to create forms window!" );
        return( FALSE );
    }

    SET_WNDINFO( info->edit_win, (LONG_PTR)info );
    SET_WNDINFO( info->forms_win, (LONG_PTR)info );

    SetWindowPos( info->forms_win, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE );

    return( TRUE );
}

bool WdeResizeEditWindows( WdeResInfo *info )
{
    RECT rect;

    if( info == NULL || info->res_win == NULL ||
        info->forms_win == NULL || info->edit_win == NULL ) {
        return( FALSE );
    }

    GetClientRect( info->res_win, &rect );

    MoveWindow( info->forms_win, 0, 0, rect.right - rect.left, rect.bottom - rect.top, TRUE );

    WdeCheckBaseScrollbars( true );

    GetClientRect( info->forms_win, &rect );

    MoveWindow( info->edit_win, 0, 0, rect.right - rect.left, rect.bottom - rect.top, TRUE );

    return( TRUE );
}

HFONT WdeGetEditFont( void )
{
    return( WdeEditFont );
}

LRESULT WdePassToEdit( UINT message, WPARAM wParam, LPARAM lParam )
{
    WdeResInfo *info;

    info = WdeGetCurrentRes();

    if( info != NULL && info->forms_win != NULL ) {
        return( SendMessage( info->forms_win, message, wParam, lParam ) );
    }

    return( FALSE );
}

WINEXPORT LRESULT CALLBACK WdeEditWndProc( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam )
{
    HWND        hwin;
    uint_32     styles;
    LRESULT     result;

#if 0
    if( WdeProcessMouse( hWnd, message, wParam, lParam ) ) {
        return( FALSE );
    }
#endif

    switch( message ) {
    case WM_KEYUP:
    case WM_KEYDOWN:
        WdePassToEdit( message, wParam, lParam );
        break;
#ifdef __NT__
    case WM_CTLCOLORSTATIC:
        hwin = (HWND)lParam;
        styles = GetWindowLong( hwin, GWL_STYLE );
        if ( (styles & SS_SIMPLE) == SS_SIMPLE ) {
            break;
        }
    case WM_CTLCOLORLISTBOX:
    case WM_CTLCOLORBTN:
    case WM_CTLCOLORSCROLLBAR:
        result = (LRESULT)WdeCtl3dCtlColorEx( message, wParam, lParam );
        if( result == (LRESULT)NULL ) {
            SetTextColor( (HDC)wParam, 0 );
            SetBkColor( (HDC)wParam, RGB( 255, 255, 255 ) );
            result = (LRESULT)WdeEditBrush;
        }
        return( result );
#else
    case WM_CTLCOLOR:
        switch( HIWORD( lParam ) ) {
        case CTLCOLOR_STATIC:
            hwin = (HWND)LOWORD( lParam );
            styles = GetWindowLong( hwin, GWL_STYLE );
            if( (styles & SS_SIMPLE) == SS_SIMPLE ) {
                break;
            }
        case CTLCOLOR_LISTBOX:
        case CTLCOLOR_BTN:
        case CTLCOLOR_SCROLLBAR:
            result = (LRESULT)WdeCtl3dCtlColorEx( message, wParam, lParam );
            if( result == (HBRUSH)NULL ) {
                SetTextColor( (HDC)wParam, 0 );
                SetBkColor( (HDC)wParam, RGB( 255, 255, 255 ) );
                result = (LRESULT)WdeEditBrush;
            }
            return( result );
        }
        break;
#endif
    }

    return( DefWindowProc( hWnd, message, wParam, lParam ) );
}

WINEXPORT LRESULT CALLBACK WdeFormsWndProc( HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam )
{
    WdeResInfo *info;
    LRESULT     result;

    info = (WdeResInfo *)GET_WNDINFO( hWnd );
    result = FALSE;

    if( info != NULL && info->editting && info->forms_win != (HWND)NULL ) {
        InitState( info->forms_win );
        result = FMEditWndProc( hWnd, message, wParam, lParam );
        if( message == WM_ERASEBKGND ) {
            SendMessage( info->edit_win, message, wParam, lParam );
            result = TRUE;
        }
    }

    if( !result ) {
        result = DefWindowProc( hWnd, message, wParam, lParam );
    }

    return( result );
}
