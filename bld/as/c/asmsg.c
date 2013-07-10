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
* Description:  Message resource handling.
*
****************************************************************************/


#include "as.h"
#include "wreslang.h"

#ifdef _STANDALONE_

#ifdef __WATCOMC__
    #include <process.h>
#endif
#include <fcntl.h>
#include "wressetr.h"
#include "wresset2.h"

#else

#define TXT_MSG_LANG_SPACING    (ABS_REF_NOT_ALLOWED - AS_MSG_BASE + 1)

// No res file to use. Just compile in the messages...
static char *asMessages[] = {
    #define pick( id, e_msg, j_msg )    e_msg,
    #include "as.msg"
    #undef pick
#if 0 
//#if defined( JAPANESE )
    #define pick( id, e_msg, j_msg )    j_msg,
    #include "as.msg"
    #undef pick
#endif
};

#define TXT_MSG_SIZE    (sizeof( asMessages ) / sizeof( asMessages[0] ))

#endif

static unsigned         msgShift;

#ifdef _STANDALONE_

#define NO_RES_MESSAGE  "Error: could not open message resource file\r\n"
#define NO_RES_SIZE     (sizeof(NO_RES_MESSAGE)-1)

extern long             FileShift;

static HANDLE_INFO      hInstance = {0};

static off_t resSeek( int handle, off_t position, int where )
//***********************************************************
{
    if( where == SEEK_SET ) {
        return( lseek( handle, position + FileShift, where ) - FileShift );
    } else {
        return( lseek( handle, position, where ) );
    }
}

WResSetRtns( open, close, read, write, resSeek, tell, MemAlloc, MemFree );
#endif

extern int AsMsgInit( void ) {
//****************************

#ifdef _STANDALONE_
    int         error;
    char        name[_MAX_PATH];

    hInstance.handle = NIL_HANDLE;
    if( _cmdname( name ) == NULL ) {
        error = 1;
    } else {
        error = OpenResFile( &hInstance, name );
        if( !error ) {
            error = FindResources( &hInstance );
            if( !error ) {
                error = InitResources( &hInstance );
            }
        }
    }
    msgShift = _WResLanguage() * MSG_LANG_SPACING;
    if( !error && !AsMsgGet( USAGE_1, name ) ) {
        error = 1;
    }
    if( error ) {
        write( STDOUT_FILENO, NO_RES_MESSAGE, NO_RES_SIZE );
        AsMsgFini();
        return 0;
    }
#else
    msgShift = _WResLanguage() * TXT_MSG_LANG_SPACING;
    if( msgShift >= TXT_MSG_SIZE )
        msgShift = 0;
    msgShift -= AS_MSG_BASE;
    return( 1 );
#endif
    return 1;
}

extern int AsMsgGet( int resourceid, char *buffer ) {
//***************************************************

#ifdef _STANDALONE_
    if( LoadString( &hInstance, resourceid + msgShift, (LPSTR)buffer, MAX_RESOURCE_SIZE ) == -1 ) {
        buffer[0] = '\0';
        return( 0 );
    }
    return( 1 );
#else
    strcpy( buffer, asMessages[resourceid + msgShift] );
    return( 1 );
#endif
}

extern void AsMsgFini( void ) {
//*****************************

#ifdef _STANDALONE_
    if( hInstance.handle != NIL_HANDLE ) {
        CloseResFile( &hInstance );
        hInstance.handle = NIL_HANDLE;
    }
#endif
}
