/****************************************************************************
*
*                            Open Watcom Project
*
*    Copyright (c) 2013 Open Watcom Contributors. All Rights Reserved.
*
* =========================================================================
*
* Description:  Environment processing.
*
****************************************************************************/


#include <stdlib.h>

char *PP_GetEnv( const char *name )
{
    return( getenv( name ) );
}
