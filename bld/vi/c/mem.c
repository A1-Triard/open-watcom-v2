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
* Description:  Internal editor memory management routines.
*
****************************************************************************/


#include "vi.h"
#include "fcbmem.h"
#include "win.h"
#ifdef __WATCOMC__
    #include <malloc.h>
#endif
#ifdef TRMEM
    #include "wio.h"
    #include "trmem.h"
#endif

#ifdef TRMEM
    #define MSIZE( x )          _trmem_msize( x, trmemHandle )
    #define WHO_PTR             _trmem_who
#else
    #define MSIZE( x )          _msize( x )
    #define WHO_PTR             void *
#endif

#ifdef TRMEM
    static FILE                 *trmemOutput = NULL;
    static _trmem_hdl           trmemHandle;
#endif

static char     *StaticBuffer = NULL;

/*
 * getMem - get and clear memory
 */
static void *getMem( size_t size, WHO_PTR who )
{
    void        *tmp;

#ifdef TRMEM
    tmp = _trmem_alloc( size, who, trmemHandle );
#else
    who = who;
    tmp = malloc( size );
#endif
    if( tmp != NULL ) {
#ifdef __WATCOMC__
        size = MSIZE( tmp );
#endif
        memset( tmp, 0, size );
    }
    return( tmp );

} /* getMem */

/*
 * getLRU - get lru block from fcb list
 */
static fcb *getLRU( int upper_bound )
{
    long lru = MAX_LONG;
    fcb *cfcb, *tfcb = NULL;
    int bootlimit = MAX_IO_BUFFER / 2;

    for( ;; ) {

        for( cfcb = FcbThreadHead; cfcb != NULL; cfcb = cfcb->thread_next ) {
            if( !cfcb->on_display && !cfcb->non_swappable && cfcb->in_memory
                && cfcb->byte_cnt >= bootlimit && cfcb != CurrentFcb ) {
                if( cfcb->last_swap == 0 ) {
                    return( cfcb );
                }
                if( cfcb->last_swap < lru ) {
                    lru = cfcb->last_swap;
                    tfcb = cfcb;
                }
            }
        }
        if( tfcb == NULL && bootlimit > 64 ) {
            bootlimit /= 2;
            if( bootlimit < upper_bound ) {
                return( NULL );
            }
            continue;
        }
        return( tfcb );
    }

} /* getLRU */

/*
 * trySwap - try to swap an fcb
 */
static void *trySwap( size_t size, int upper_bound, WHO_PTR who )
{
    void        *tmp = NULL;
    fcb         *tfcb;

    for( ;; ) {

        /*
         * find LRU fcb
         */
        tfcb = getLRU( upper_bound );
        if( tfcb == NULL ) {
            break;
        }

        /*
         * swap the LRU fcb, and re-attempt allocation
         */
        SwapFcb( tfcb );
        tmp = getMem( size, who );
        if( tmp != NULL ) {
            break;
        }

    }

    return( tmp );

} /* trySwap */

/*
 * tossBoundData - get rid of bound data
 */
static void tossBoundData( void )
{
    if( BoundData ) {
        if( !EditFlags.BndMemoryLocked ) {
            MemFreePtr( (void **)&BndMemory );
        }
    }

} /* tossBoundData */



/*
 * doMemAllocUnsafe - see above
 */
static void *doMemAllocUnsafe( size_t size, WHO_PTR who )
{
    void        *tmp;

    tmp = getMem( size, who );
    if( tmp == NULL ) {
        tossBoundData();
        tmp = trySwap( size, 1, who );
        if( tmp == NULL ) {
            SwapAllWindows();
            while( (tmp = getMem( size, who )) == NULL ) {
                if( !TossUndos() ) {
                    return( NULL );
                }
            }
        }
    }
    return( tmp );
}

/*
 * MemAlloc - allocate some memory (always works, or editor aborts)
 */
void *MemAlloc( size_t size )
{
    void        *tmp;

#ifdef TRMEM
#ifndef __WATCOMC__
    tmp = doMemAllocUnsafe( size, (WHO_PTR)1 );
#else
    tmp = doMemAllocUnsafe( size, _trmem_guess_who() );
#endif
#else
    tmp = doMemAllocUnsafe( size, (WHO_PTR)0 );
#endif
    if( tmp == NULL ) {
        AbandonHopeAllYeWhoEnterHere( ERR_NO_MEMORY );
    }
    return( tmp );

} /* MemAlloc */

/*
 * MemAllocUnsafe - allocate some memory, return null if it fails
 */
void *MemAllocUnsafe( size_t size )
{
#ifdef TRMEM
#ifndef __WATCOMC__
    return( doMemAllocUnsafe( size, (WHO_PTR)2 ) );
#else
    return( doMemAllocUnsafe( size, _trmem_guess_who() ) );
#endif
#else
    return( doMemAllocUnsafe( size, (WHO_PTR)0 ) );
#endif

} /* MemAllocUnsafe */

/*
 * MemFree - free up memory
 */
void MemFree( void *ptr )
{
#ifdef TRMEM
#ifndef __WATCOMC__
    _trmem_free( ptr, (WHO_PTR)3, trmemHandle );
#else
    _trmem_free( ptr, _trmem_guess_who(), trmemHandle );
#endif
#else
    free( ptr );
#endif

} /* MemFree */

/*
 * MemFreePtr - free up memory
 */
void MemFreePtr( void **ptr )
{
#ifdef TRMEM
#ifndef __WATCOMC__
    _trmem_free( *ptr, (WHO_PTR)4, trmemHandle );
#else
    _trmem_free( *ptr, _trmem_guess_who(), trmemHandle );
#endif
#else
    free( *ptr );
#endif
    *ptr = NULL;

} /* MemFreePtr */


/*
 * MemFreeList - free up memory
 */
void MemFreeList( int count, char **ptr )
{
    if( ptr != NULL ) {
        int i;
        for( i = 0; i < count; i++ ) {
            MemFree( ptr[i] );
        }
        MemFree( ptr );
    }

} /* MemFreeList */


/*
 * doMemReallocUnsafe - reallocate a block, return NULL if it fails
 */
static void *doMemReAllocUnsafe( void *ptr, size_t size, WHO_PTR who )
{
    void        *tmp;

    size_t      orig_size;
#ifdef __WATCOMC__
    size_t      tsize;
#endif

    if( ptr != NULL ) {
#ifdef __WATCOMC__
        orig_size = MSIZE( ptr );
#else
        orig_size = 0xffffffff;
#endif
    } else {
        orig_size = 0;
    }

#ifdef TRMEM
    tmp = _trmem_realloc( ptr, size, who, trmemHandle );
#else
    who = who;
    tmp = realloc( ptr, size );
#endif
#ifdef __WATCOMC__
    if( tmp == NULL ) {
        tmp = doMemAllocUnsafe( size, who );
        if( tmp == NULL ) {
            return( NULL );
        }
        size = MSIZE( tmp );
        if( orig_size != 0 ) {
            tsize = orig_size;
            if( tsize > size ) {
                tsize = size;
            }
            memcpy( tmp, ptr, tsize );
            MemFree( ptr );
        }
    } else
#endif
    {
#ifdef __WATCOMC__
        size = MSIZE( tmp );
#endif
        if( size > orig_size ) {
            memset( &(((char *)tmp)[orig_size]), 0, size - orig_size );
        }
    }
    return( tmp );

} /* doMemReAllocUnsafe */

void *MemReAllocUnsafe( void *ptr, size_t size )
{
#ifdef TRMEM
#ifndef __WATCOMC__
    return( doMemReAllocUnsafe( ptr, size, (WHO_PTR)5 ) );
#else
    return( doMemReAllocUnsafe( ptr, size, _trmem_guess_who() ) );
#endif
#else
    return( doMemReAllocUnsafe( ptr, size, (WHO_PTR)0 ) );
#endif
}

/*
 * MemReAlloc - reallocate a block, and it will succeed.
 */
void *MemReAlloc( void *ptr, size_t size )
{
    void        *tmp;

#ifdef TRMEM
#ifndef __WATCOMC__
    tmp = doMemReAllocUnsafe( ptr, size, (WHO_PTR)6 );
#else
    tmp = doMemReAllocUnsafe( ptr, size, _trmem_guess_who() );
#endif
#else
    tmp = doMemReAllocUnsafe( ptr, size, (WHO_PTR)0 );
#endif
    if( tmp == NULL ) {
        AbandonHopeAllYeWhoEnterHere( ERR_NO_MEMORY );
    }
    return( tmp );

} /* MemReAlloc */

static char *staticBuffs[MAX_STATIC_BUFFERS];
static bool staticUse[MAX_STATIC_BUFFERS];
int         maxStatic = 0;

/*
 * StaticAlloc - allocate one of the static buffers
 */
void *StaticAlloc( void )
{
    int i;

    for( i = 0; i < MAX_STATIC_BUFFERS; i++ ) {
        if( !staticUse[i] ) {
            staticUse[i] = true;
            {
                int j, k = 0;
                for( j = 0; j < MAX_STATIC_BUFFERS; j++ ) {
                    if( staticUse[j] ) {
                        k++;
                    }
                }
                if( k > maxStatic ) {
                    maxStatic = k;
                }
            }
            return( staticBuffs[i] );
        }
    }
    return( NULL );

} /* StaticAlloc */

/*
 * StaticFree - free a static buffer
 */
void StaticFree( char *item )
{
    int i;

    for( i = 0; i < MAX_STATIC_BUFFERS; i++ ) {
        if( item == staticBuffs[i] ) {
            staticUse[i] = false;
            return;
        }
    }

} /* StaticFree */

/*
 * StaticStart - start up static buffer
 */
void StaticStart( void )
{
    int i, bs;

    MemFree( StaticBuffer );
    bs = EditVars.MaxLine + 2;
    StaticBuffer = MemAlloc( MAX_STATIC_BUFFERS * bs );
    for( i = 0; i < MAX_STATIC_BUFFERS; i++ ) {
        staticUse[i] = false;
        staticBuffs[i] = &StaticBuffer[i * bs];
    }

} /* StaticStart */

void StaticFini( void )
{
    MemFree( StaticBuffer );
}

/*
 * MemStrDup - Safe strdup()
 */
char *MemStrDup( char *string )
{
    char *rptr;

    if( string == NULL ){
        rptr = NULL;
    } else {
        rptr = (char *)MemAlloc( strlen( string ) + 1 );
        strcpy( rptr, string );
    }
    return( rptr );
}


#ifdef TRMEM

extern void trmemPrint( void *handle, const char *buff, size_t len )
/******************************************************************/
{
    handle = handle;
    if( trmemOutput != NULL ) {
        fwrite( buff, 1, len, trmemOutput );
    }
}

#endif

void FiniMem( void )
{
#ifdef TRMEM
    _trmem_prt_list( trmemHandle );
    _trmem_close( trmemHandle );
    if( trmemOutput != NULL ) {
        fclose( trmemOutput );
    }
#endif
}

void InitMem( void )
{
#ifdef TRMEM
    trmemOutput = fopen( "trmem.out", "w" );
    trmemHandle = _trmem_open( malloc, free, realloc, NULL,
        NULL, trmemPrint,
        _TRMEM_ALLOC_SIZE_0 | _TRMEM_REALLOC_SIZE_0 |
        _TRMEM_OUT_OF_MEMORY | _TRMEM_CLOSE_CHECK_FREE );
    // atexit( DumpTRMEM );
#endif
}

#ifdef __DOS__

#include "xmem.h"

#if defined( USE_XTD )
extern xtd_struct XMemCtrl;
#endif
#if defined( USE_EMS )
extern ems_struct EMSCtrl;
#endif
#if defined( USE_XMS )
extern xms_struct XMSCtrl;
#endif
#endif
static char freeBytes[] =  "%s:  %l bytes free (%d%%)";
static char twoStr[] = "%Y%s";
extern int maxStatic;
//extern long __undocnt;

/*
 * DumpMemory - dump memory avaliable
 */
vi_rc DumpMemory( void )
{
    int         ln = 1;
    window_id   wn;
    window_info *wi;
    char        tmp[128], tmp2[128];
#if defined( USE_XMS ) || defined( USE_EMS ) || defined( USE_XTD )
    long        mem1;
#endif
    long        mem2;
//    vi_rc       rc;

    wi = &filecw_info;
//    rc = NewWindow2( &wn, wi );
    NewWindow2( &wn, wi );
#if defined(__OS2__ )
    WPrintfLine( wn, ln++, "Mem:  (unlimited) (maxStatic=%d)", maxStatic );
#else
    WPrintfLine( wn, ln++, "Mem:  %l bytes memory (%l for editing) (maxStatic=%d)",
        MaxMemFree, MaxMemFreeAfterInit, maxStatic );
#endif

    mem2 = (EditVars.MaxSwapBlocks - SwapBlocksInUse) * (long)MAX_IO_BUFFER;
    MySprintf( tmp, freeBytes, "Dsk", mem2,
        (int) ((100L * mem2) / ((long)EditVars.MaxSwapBlocks * (long)MAX_IO_BUFFER)) );
#ifdef _M_I86
#if defined( USE_XTD )
    if( XMemCtrl.inuse ) {
        mem1 = XMemCtrl.amount_left - XMemCtrl.allocated * (long)MAX_IO_BUFFER;
        MySprintf( tmp2, freeBytes, "XTD", mem1,
            (int) ((100L * mem1) / XMemCtrl.amount_left) );
    } else {
#endif
        MySprintf( tmp2, "XTD: N/A" );
#if defined( USE_XTD )
    }
#endif
#else
    MySprintf( tmp2, "Flat memory addressing" );
#endif
    WPrintfLine( wn, ln++, twoStr, tmp, tmp2 );

#if defined( USE_EMS )
    if( EMSCtrl.inuse ) {
        mem1 = (long)(TotalEMSBlocks - EMSBlocksInUse) * (long)MAX_IO_BUFFER;
        MySprintf( tmp, freeBytes, "EMS", mem1,
                (int) ((100L * mem1) / ((long)TotalEMSBlocks * (long)MAX_IO_BUFFER)) );
    } else {
#endif
        MySprintf( tmp, "EMS:  N/A" );
#if defined( USE_EMS )
    }
#endif
#if defined( USE_XMS )
    if( XMSCtrl.inuse ) {
        mem1 = (long)(TotalXMSBlocks - XMSBlocksInUse) * (long)MAX_IO_BUFFER;
        MySprintf( tmp2, freeBytes, "XMS", mem1,
            (int) ((100L * mem1) / ((long)TotalXMSBlocks * (long)MAX_IO_BUFFER)) );
    } else {
#endif
        MySprintf( tmp2, "XMS: N/A" );
#if defined( USE_XMS )
    }
#endif
    WPrintfLine( wn, ln++, twoStr, tmp, tmp2 );
//    WPrintfLine( wn, ln++, "Reserved %l bytes of DOS memory", MinMemoryLeft );

    WPrintfLine( wn, ln++, "File CB's: %d", FcbBlocksInUse );
//    WPrintfLine( wn, ln++, "File CB's: %d, Undo blocks=%l(%l bytes)", FcbBlocksInUse,
//        __undocnt, __undocnt * sizeof( undo ) );

    WPrintfLine( wn, ln + 1, MSG_PRESSANYKEY );

    GetNextEvent( false );
    CloseAWindow( wn );
    return( ERR_NO_ERR );

} /* DumpMemory */
