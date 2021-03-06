cdef extern from "ncomp/constants.h":
    cdef double DEFAULT_FILL "DEFAULT_FILL_DOUBLE";
    cdef char   DEFAULT_FILL_INT8 "NC_FILL_BYTE";
    cdef short  DEFAULT_FILL_INT16 "NC_FILL_SHORT";
    cdef int    DEFAULT_FILL_INT32 "NC_FILL_INT";
    cdef long   DEFAULT_FILL_INT64 "NC_FILL_INT64";
    cdef float  DEFAULT_FILL_FLOAT "NC_FILL_FLOAT";
    cdef double DEFAULT_FILL_DOUBLE "NC_FILL_DOUBLE";
    cdef char   DEFAULT_FILL_CHAR "DEFAULT_FILL_CHAR";

cdef extern from "ncomp/types.h":
    cdef enum NCOMP_TYPES:
        NCOMP_BOOL
        NCOMP_BYTE
        NCOMP_UBYTE
        NCOMP_SHORT
        NCOMP_USHORT
        NCOMP_INT
        NCOMP_UINT
        NCOMP_LONG
        NCOMP_ULONG
        NCOMP_LONGLONG
        NCOMP_ULONGLONG
        NCOMP_FLOAT
        NCOMP_DOUBLE
        NCOMP_LONGDOUBLE

    ctypedef union ncomp_missing:
        char                msg_bool
        signed char         msg_byte
        unsigned char       msg_ubyte
        short               msg_short
        unsigned short      msg_ushort
        int                 msg_int
        unsigned int        msg_uint
        long                msg_long
        unsigned long       msg_ulong
        long long           msg_longlong
        unsigned long long  msg_ulonglong
        float               msg_float
        double              msg_double
        long double         msg_longdouble

    ctypedef struct ncomp_array:
        int             type
        int             ndim
        void*           addr
        int             has_missing
        ncomp_missing   msg
        size_t          shape[1]

cdef extern from "ncomp/util.h":
    ncomp_array* ncomp_array_alloc(void*, int, int, size_t*)
    void         ncomp_array_free(ncomp_array*, int)
