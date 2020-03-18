/*
 *  lmsvc.h     LAN Manager service functions
 *
 * =========================================================================
 *
 *                          Open Watcom Project
 *
 * Copyright (c) 2004-2010 The Open Watcom Contributors. All Rights Reserved.
 *
 *    This file is automatically generated. Do not edit directly.
 *
 * =========================================================================
 */

#ifndef _LMSVC_
#define _LMSVC_

#ifndef _ENABLE_AUTODEPEND
 #pragma read_only_file;
#endif

#include <lmsname.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Service status flags */
#define SERVICE_INSTALL_STATE           0x00000003L
#define SERVICE_UNINSTALLED             0x00000000L
#define SERVICE_INSTALL_PENDING         0x00000001L
#define SERVICE_UNINSTALL_PENDING       0x00000002L
#define SERVICE_INSTALLED               0x00000003L
#define SERVICE_PAUSE_STATE             0x0000000CL
#define LM20_SERVICE_ACTIVE             0x00000000L
#define LM20_SERVICE_CONTINUE_PENDING   0x00000004L
#define LM20_SERVICE_PAUSE_PENDING      0x00000008L
#define LM20_SERVICE_PAUSED             0x0000000CL
#define SERVICE_NOT_UNINSTALLABLE       0x00000000L
#define SERVICE_UNINSTALLABLE           0x00000010L
#define SERVICE_NOT_PAUSABLE            0x00000000L
#define SERVICE_PAUSABLE                0x00000020L
#define SERVICE_REDIR_PAUSED            0x00000700L
#define SERVICE_REDIR_DISK_PAUSED       0x00000100L
#define SERVICE_REDIR_PRINT_PAUSED      0x00000200L
#define SERVICE_REDIR_COMM_PAUSED       0x00000400L

/* DOS encryption service */
#define SERVICE_DOS_ENCRYPTION  L"ENCRYPT"

/* NetServiceControl() operation codes */
#define SERVICE_CTRL_INTERROGATE    0L
#define SERVICE_CTRL_PAUSE          1L
#define SERVICE_CTRL_CONTINUE       2L
#define SERVICE_CTRL_UNINSTALL      3L

/* NetServiceControl() redirection flags */
#define SERVICE_CTRL_REDIR_DISK     0x00000001L
#define SERVICE_CTRL_REDIR_PRINT    0x00000002L
#define SERVICE_CTRL_REDIR_COMM     0x00000004L

/* Service code flags */
#define SERVICE_IP_NO_HINT      0x00000000L
#define SERVICE_CCP_NO_HINT     0x00000000L
#define SERVICE_IP_QUERY_HINT   0x00010000L
#define SERVICE_CCP_QUERY_HINT  0x00010000L

/* Service code masks */
#define SERVICE_IP_CHKPT_NUM    0x000000FFL
#define SERVICE_CCP_CHKPT_NUM   0x000000FFL
#define SERVICE_IP_WAIT_TIME    0x0000FF00L
#define SERVICE_CCP_WAIT_TIME   0x0000FF00L
#define UPPER_HINT_MASK         0x0000FF00L
#define LOWER_HINT_MASK         0x000000FFL
#define UPPER_GET_HINT_MASK     0x0FF00000L
#define LOWER_GET_HINT_MASK     0x0000FF00L
#define SERVICE_NT_MAXTIME      0x0000FFFFL
#define SERVICE_RESRV_MASK      0x00001FFFL
#define SERVICE_MAXTIME         0x000000FFL

/* Service code shifts */
#define SERVICE_IP_WAITTIME_SHIFT   8
#define SERVICE_NTIP_WAITTIME_SHIFT 12

/* Service error codes */
#define SERVICE_BASE                    3050L
#define SERVICE_UIC_NORMAL              0L
#define SERVICE_UIC_BADPARMVAL          (SERVICE_BASE + 1)
#define SERVICE_UIC_MISSPARM            (SERVICE_BASE + 2)
#define SERVICE_UIC_UNKPARM             (SERVICE_BASE + 3)
#define SERVICE_UIC_RESOURCE            (SERVICE_BASE + 4)
#define SERVICE_UIC_CONFIG              (SERVICE_BASE + 5)
#define SERVICE_UIC_SYSTEM              (SERVICE_BASE + 6)
#define SERVICE_UIC_INTERNAL            (SERVICE_BASE + 7)
#define SERVICE_UIC_AMBIGPARM           (SERVICE_BASE + 8)
#define SERVICE_UIC_DUPPARM             (SERVICE_BASE + 9)
#define SERVICE_UIC_KILL                (SERVICE_BASE + 10)
#define SERVICE_UIC_EXEC                (SERVICE_BASE + 11)
#define SERVICE_UIC_SUBSERV             (SERVICE_BASE + 12)
#define SERVICE_UIC_CONFLPARM           (SERVICE_BASE + 13)
#define SERVICE_UIC_FILE                (SERVICE_BASE + 14)
#define SERVICE_UIC_M_NULL              0L
#define SERVICE_UIC_M_MEMORY            (SERVICE_BASE + 20)
#define SERVICE_UIC_M_DISK              (SERVICE_BASE + 21)
#define SERVICE_UIC_M_THREADS           (SERVICE_BASE + 22)
#define SERVICE_UIC_M_PROCESSES         (SERVICE_BASE + 23)
#define SERVICE_UIC_M_SECURITY          (SERVICE_BASE + 24)
#define SERVICE_UIC_M_LANROOT           (SERVICE_BASE + 25)
#define SERVICE_UIC_M_REDIR             (SERVICE_BASE + 26)
#define SERVICE_UIC_M_SERVER            (SERVICE_BASE + 27)
#define SERVICE_UIC_M_SEC_FILE_ERR      (SERVICE_BASE + 28)
#define SERVICE_UIC_M_FILES             (SERVICE_BASE + 29)
#define SERVICE_UIC_M_LOGS              (SERVICE_BASE + 30)
#define SERVICE_UIC_M_LANGROUP          (SERVICE_BASE + 31)
#define SERVICE_UIC_M_MSGNAME           (SERVICE_BASE + 32)
#define SERVICE_UIC_M_ANNOUNCE          (SERVICE_BASE + 33)
#define SERVICE_UIC_M_UAS               (SERVICE_BASE + 34)
#define SERVICE_UIC_M_SERVER_SEC_ERR    (SERVICE_BASE + 35)
#define SERVICE_UIC_M_WKSTA             (SERVICE_BASE + 37)
#define SERVICE_UIC_M_ERRLOG            (SERVICE_BASE + 38)
#define SERVICE_UIC_M_FILE_UW           (SERVICE_BASE + 39)
#define SERVICE_UIC_M_ADDPAK            (SERVICE_BASE + 40)
#define SERVICE_UIC_M_LAZY              (SERVICE_BASE + 41)
#define SERVICE_UIC_M_UAS_MACHINE_ACCT  (SERVICE_BASE + 42)
#define SERVICE_UIC_M_UAS_SERVERS_NMEMB (SERVICE_BASE + 43)
#define SERVICE_UIC_M_UAS_SERVERS_NOGRP (SERVICE_BASE + 44)
#define SERVICE_UIC_M_UAS_INVALID_ROLE  (SERVICE_BASE + 45)
#define SERVICE_UIC_M_NETLOGON_NO_DC    (SERVICE_BASE + 46)
#define SERVICE_UIC_M_NETLOGON_DC_CFLCT (SERVICE_BASE + 47)
#define SERVICE_UIC_M_NETLOGON_AUTH     (SERVICE_BASE + 48)
#define SERVICE_UIC_M_UAS_PROLOG        (SERVICE_BASE + 49)
#define SERVICE2_BASE                   5600L
#define SERVICE_UIC_M_NETLOGON_MPATH    (SERVICE2_BASE + 0)
#define SERVICE_UIC_M_LSA_MACHINE_ACCT  (SERVICE2_BASE + 1)
#define SERVICE_UIC_M_DATABASE_ERROR    (SERVICE2_BASE + 2)

/* Macros to manipulate service codes */
#define SERVICE_IP_CODE( p1, p2 ) \
    ((long)SERVICE_IP_QUERY_HINT | (long)(p2 | (p1 << SERVICE_IP_WAITTIME_SHIFT)))
#define SERVICE_CCP_CODE( p1, p2 ) \
    ((long)SERVICE_CCP_QUERY_HINT | (long)(p2 | (p1 << SERVICE_IP_WAITTIME_SHIFT)))
#define SERVICE_UIC_CODE( p1, p2 ) \
    ((long)(((long)(p1) << 16) | (long)(unsigned short)(p2)))
#define SERVICE_NT_CCP_CODE( p1, p2 ) \
    (((long)SERVICE_CCP_QUERY_HINT) | ((long)(p2)) | (((p1) & LOWER_HINT_MASK) << \
    SERVICE_IP_WAITTIME_SHIFT) | (((p1) & UPPER_HINT_MASK) << \
    SERVICE_NTIP_WAITTIME_SHIFT)
#define SERVICE_NT_WAIT_GET( x ) \
    ((((x) & UPPER_GET_HINT_MASK) >> SERVICE_NTIP_WAITTIME_SHIFT) | \
    (((x) & LOWER_GET_HINT_MASK) >> SERVICE_IP_WAITTIME_SHIFT))

/* Service information (level 0) */
typedef struct _SERVICE_INFO_0 {
    LPWSTR  svci0_name;
} SERVICE_INFO_0;
typedef SERVICE_INFO_0  *PSERVICE_INFO_0;
typedef SERVICE_INFO_0  *LPSERVICE_INFO_0;

/* Service information (level 1) */
typedef struct _SERVICE_INFO_1 {
    LPWSTR  svci1_name;
    DWORD   svci1_status;
    DWORD   svci1_code;
    DWORD   svci1_pid;
} SERVICE_INFO_1;
typedef SERVICE_INFO_1  *PSERVICE_INFO_1;
typedef SERVICE_INFO_1  *LPSERVICE_INFO_1;

/* Service information (level 2) */
typedef struct _SERVICE_INFO_2 {
    LPWSTR  svci2_name;
    DWORD   svci2_status;
    DWORD   svci2_code;
    DWORD   svci2_pid;
    LPWSTR  svci2_text;
    DWORD   svci2_specific_error;
    LPWSTR  svci2_display_name;
} SERVICE_INFO_2;
typedef SERVICE_INFO_2  *PSERVICE_INFO_2;
typedef SERVICE_INFO_2  *LPSERVICE_INFO_2;

/* Functions in NETAPI32.DLL */
NET_API_STATUS NET_API_FUNCTION NetServiceControl( LPCWSTR, LPCWSTR, DWORD, DWORD, LPBYTE * );
NET_API_STATUS NET_API_FUNCTION NetServiceEnum( LPCWSTR, DWORD, LPBYTE *, DWORD, LPDWORD, LPDWORD, LPDWORD );
NET_API_STATUS NET_API_FUNCTION NetServiceGetInfo( LPCWSTR, LPCWSTR, DWORD, LPBYTE * );
NET_API_STATUS NET_API_FUNCTION NetServiceInstall( LPCWSTR, LPCWSTR, DWORD, LPCWSTR [], LPBYTE * );

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* _LMSVC_ */