
#ifdef  __MINGW32__
#ifndef __USE_MINGW_ANSI_STDIO
#define __USE_MINGW_ANSI_STDIO 1
#endif
#endif

#define PERL_NO_GET_CONTEXT 1

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>

#ifdef _MSC_VER
#pragma warning(disable:4700 4715 4716)
#endif

#if defined MATH_GMPF_NEED_LONG_LONG_INT
#ifndef _MSC_VER
#include <inttypes.h>
#endif
#endif

#define NEG_ZERO_BUG 50103 /* A bug affecting mpf_fits_u*_p functions     */
                           /* Fixed in gmp after __GNU_MP_RELEASE 50103 ? */

#ifdef OLDPERL
#define SvUOK SvIsUV
#endif

#ifndef Newx
#  define Newx(v,n,t) New(0,v,n,t)
#endif

#ifndef Newxz
#  define Newxz(v,n,t) Newz(0,v,n,t)
#endif

unsigned long Rmpf_get_default_prec(void) {
     return mpf_get_default_prec();
     }

void Rmpf_set_default_prec(pTHX_ SV * prec) {
     mpf_set_default_prec(SvUV(prec));
     }

SV * Rmpf_init_set_str_nobless(pTHX_ SV * str, SV * base) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set_str_nobless function");
     if(mpf_init_set_str(*mpf_t_obj, SvPV_nolen(str), SvIV(base)))
       croak("First arg to Rmpf_init_set_str_nobless is not a valid base %d number", (signed long int)SvIV(base));
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init2_nobless(pTHX_ SV * prec) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init2_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     mpf_init2 (*mpf_t_obj, SvUV(prec));

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;

}

SV * Rmpf_init_set_str(pTHX_ SV * str, SV * base) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set_str function");
     if(mpf_init_set_str(*mpf_t_obj, SvPV_nolen(str), SvIV(base)))
       croak("First arg to Rmpf_init_set_str is not a valid base %d number", (int)SvIV(base));
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init2(pTHX_ SV * prec) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init2 function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     mpf_init2 (*mpf_t_obj, SvUV(prec));

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init_nobless(pTHX) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     mpf_init(*mpf_t_obj);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;

}

SV * Rmpf_init(pTHX) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     mpf_init(*mpf_t_obj);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init_set(pTHX_ mpf_t * a) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     mpf_init_set(*mpf_t_obj, *a);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init_set_ui(pTHX_ unsigned long a) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set_ui function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     mpf_init_set_ui(*mpf_t_obj, a);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init_set_si(pTHX_ long a) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set_si function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     mpf_init_set_si(*mpf_t_obj, a);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init_set_d(pTHX_ double a) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set_d function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     mpf_init_set_d(*mpf_t_obj, a);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

void _Rmpf_set_ld(pTHX_ mpf_t * q, SV * p) {
#ifdef USE_LONG_DOUBLE
     char buffer[50];
     int exp, exp2 = 0;
     long double fr;

     fr = frexpl((long double)SvNV(p), &exp);

     while(fr != floorl(fr)) {
          fr *= 2;
          exp2 += 1;
     }

     sprintf(buffer, "%.0Lf", fr);

     mpf_set_str(*q, buffer, 10);

     if (exp2 > exp) mpf_div_2exp(*q, *q, exp2 - exp);
     else mpf_mul_2exp(*q, *q, exp - exp2);
#else
     croak("_Rmpf_set_ld not implemented on this build of perl");
#endif
}

SV * Rmpf_init_set_nobless(pTHX_ mpf_t * a) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     mpf_init_set(*mpf_t_obj, *a);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init_set_ui_nobless(pTHX_ unsigned long a) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set_ui_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     mpf_init_set_ui(*mpf_t_obj, a);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init_set_si_nobless(pTHX_ long a) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set_si_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     mpf_init_set_si(*mpf_t_obj, a);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * Rmpf_init_set_d_nobless(pTHX_ double a) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in Rmpf_init_set_d_nobless function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, NULL);
     mpf_init_set_d(*mpf_t_obj, a);

     sv_setiv(obj, INT2PTR(IV,mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

void Rmpf_deref2(pTHX_ mpf_t * p, SV * base, SV * n_digits) {
     dXSARGS;
     char * out;
     mp_exp_t ptr;
     int b = (int)SvIV(base);
     size_t n_dig = (size_t)SvUV(n_digits);

     if(!n_dig) {
        n_dig = (double)(mpf_get_prec(*p)) / log(b) * log(2);
        }

     if((b < 2 && b > -2) || b > 62 || b < -36) croak("Second argument supplied to Rmpf_get_str is not in acceptable range");

     New(2, out, n_dig + 5 , char);
     if(out == NULL) croak("Failed to allocate memory in Rmpf_get_str function");

     mpf_get_str(out, &ptr, b, SvUV(n_digits), *p);

     /* sp = mark; */ /* not needed */
     ST(0) = sv_2mortal(newSVpv(out, 0));
     Safefree(out);
     ST(1) = sv_2mortal(newSViv(ptr));
     /* PUTBACK; */ /* not needed */
     XSRETURN(2);
}

void DESTROY(pTHX_ mpf_t * p) {
/*     printf("Destroying mpf "); */
     mpf_clear(*p);
     Safefree(p);
/*     printf("...destroyed\n"); */
}

void Rmpf_clear(pTHX_ mpf_t * p) {
     mpf_clear(*p);
     Safefree(p);
}

void Rmpf_clear_mpf(pTHX_ mpf_t * p) {
     mpf_clear(*p);
}

void Rmpf_clear_ptr(pTHX_ mpf_t * p) {
     Safefree(p);
}

SV * Rmpf_get_prec(pTHX_ mpf_t * p) {
     return newSVuv(mpf_get_prec(*p));
}

void Rmpf_set_prec(pTHX_ mpf_t * p, SV * prec) {
     mpf_set_prec(*p, SvUV(prec));
}

void Rmpf_set_prec_raw(pTHX_ mpf_t * p, SV * prec) {
     mpf_set_prec_raw(*p, SvUV(prec));
}

void Rmpf_set(mpf_t * p1, mpf_t * p2) {
     mpf_set(*p1, *p2);
}

void Rmpf_set_ui(mpf_t * p, unsigned long ul) {
     mpf_set_ui(*p, ul);
}

void Rmpf_set_si(mpf_t * p, long l) {
     mpf_set_si(*p, l);
}

void Rmpf_set_d(mpf_t * p, double d) {
     mpf_set_d(*p, d);
}

void Rmpf_set_z(mpf_t * p, mpz_t * z) {
     mpf_set_z(*p, *z );
}

void Rmpf_set_q(mpf_t * p, mpq_t * q) {
     mpf_set_q(*p, *q );
}

void Rmpf_set_str(pTHX_ mpf_t * p, SV * str, int base) {
     if(mpf_set_str(*p, SvPV_nolen(str), base))
      croak("2nd arg to Rmpf_set_str is not a valid base %d number", base);
}

void Rmpf_swap(mpf_t * p1, mpf_t * p2) {
     mpf_swap(*p1, *p2);
}

SV * _TRmpf_out_str(pTHX_ FILE * stream, int base, SV * dig, mpf_t * p) {
     size_t ret;
     ret = mpf_out_str(stream, base, (size_t)SvUV(dig), *p);
     fflush(stream);
     return newSVuv(ret);
}

SV * _Rmpf_out_str(pTHX_ mpf_t * p, int base, SV * dig) {
     size_t ret;
     ret = mpf_out_str(NULL, base, (size_t)SvUV(dig), *p);
     fflush(stdout);
     return newSVuv(ret);
}

SV * _TRmpf_out_strS(pTHX_ FILE * stream, int base, SV * dig, mpf_t * p, SV * suff) {
     size_t ret;
     ret = mpf_out_str(stream, base, (size_t)SvUV(dig), *p);
     fflush(stream);
     fprintf(stream, "%s", SvPV_nolen(suff));
     return newSVuv(ret);
}

SV * _TRmpf_out_strP(pTHX_ SV * pre, FILE * stream, int base, SV * dig, mpf_t * p) {
     size_t ret;
     fprintf(stream, "%s", SvPV_nolen(pre));
     fflush(stream);
     ret = mpf_out_str(stream, base, (size_t)SvUV(dig), *p);
     fflush(stream);
     return newSVuv(ret);
}

SV * _TRmpf_out_strPS(pTHX_ SV * pre, FILE * stream, int base, SV * dig, mpf_t * p, SV * suff) {
     size_t ret;
     fprintf(stream, "%s", SvPV_nolen(pre));
     fflush(stream);
     ret = mpf_out_str(stream, base, (size_t)SvUV(dig), *p);
     fflush(stream);
     fprintf(stream, "%s", SvPV_nolen(suff));
     fflush(stream);
     return newSVuv(ret);
}

SV * _Rmpf_out_strS(pTHX_ mpf_t * p, int base, SV * dig, SV * suff) {
     size_t ret;
     ret = mpf_out_str(NULL, base, (size_t)SvUV(dig), *p);
     printf("%s", SvPV_nolen(suff));
     fflush(stdout);
     return newSVuv(ret);
}

SV * _Rmpf_out_strP(pTHX_ SV * pre, mpf_t * p, int base, SV * dig) {
     size_t ret;
     printf("%s", SvPV_nolen(pre));
     ret = mpf_out_str(NULL, base, (size_t)SvUV(dig), *p);
     fflush(stdout);
     return newSVuv(ret);
}

SV * _Rmpf_out_strPS(pTHX_ SV * pre, mpf_t * p, int base, SV * dig, SV * suff) {
     size_t ret;
     printf("%s", SvPV_nolen(pre));
     ret = mpf_out_str(NULL, base, (size_t)SvUV(dig), *p);
     printf("%s", SvPV_nolen(suff));
     fflush(stdout);
     return newSVuv(ret);
}

SV * TRmpf_inp_str(pTHX_ mpf_t * p, FILE * stream, int base) {
     size_t ret;
     ret = mpf_inp_str(*p, stream, base);
     /* fflush(stream); */
     return newSVuv(ret);
}

SV * Rmpf_inp_str(pTHX_ mpf_t * p, int base) {
     size_t ret;
     ret = mpf_inp_str(*p, NULL, base);
     /* fflush(stdin); */
     return newSVuv(ret);
}


int Rmpf_cmp(mpf_t * p1, mpf_t * p2) {
     return mpf_cmp(*p1, *p2);
}

int Rmpf_cmp_ui(mpf_t * p, unsigned long ul) {
     return mpf_cmp_ui(*p, ul);
}

int Rmpf_cmp_si(mpf_t * p, long l) {
     return mpf_cmp_si(*p, l);
}

int Rmpf_cmp_d(mpf_t * p, double d) {
     return mpf_cmp_d(*p, d);
}

double Rmpf_get_d(mpf_t * p) {
     return mpf_get_d(*p);
}

long Rmpf_get_si(mpf_t * p) {
     return mpf_get_si(*p);
}

unsigned long Rmpf_get_ui(mpf_t * p) {
     return mpf_get_ui(*p);
}

void Rmpf_get_d_2exp(pTHX_ mpf_t * n) {
     dXSARGS;
     double d;
     long exp;

     d = mpf_get_d_2exp(&exp, *n);

     /* sp = mark; */ /* not needed */
     EXTEND(SP, 2);
     ST(0) = sv_2mortal(newSVnv(d));
     ST(1) = sv_2mortal(newSViv(exp));
     /* PUTBACK; */ /* not needed */
     XSRETURN(2);
}

void Rmpf_add(mpf_t * dest, mpf_t * src1, mpf_t * src2) {
     mpf_add(*dest, *src1, *src2 );
}

void Rmpf_add_ui(mpf_t * dest, mpf_t * src, unsigned long num) {
     mpf_add_ui(*dest, *src, num);
}

void Rmpf_sub(mpf_t * dest, mpf_t * src1, mpf_t * src2) {
     mpf_sub(*dest, *src1, *src2 );
}

void Rmpf_sub_ui(mpf_t * dest, mpf_t * src, unsigned long num) {
     mpf_sub_ui(*dest, *src, num);
}

void Rmpf_ui_sub(mpf_t * dest, unsigned long num, mpf_t * src) {
     mpf_ui_sub(*dest, num, *src);
}

void Rmpf_mul(mpf_t * dest, mpf_t * src1, mpf_t * src2) {
     mpf_mul(*dest, *src1, *src2 );
}

void Rmpf_mul_ui(mpf_t * dest, mpf_t * src, unsigned long num) {
     mpf_mul_ui(*dest, *src, num);
}

void Rmpf_div(mpf_t * d, mpf_t * p, mpf_t * q) {
     mpf_div(*d, *p, *q);
}

void Rmpf_ui_div(mpf_t * d, unsigned long p, mpf_t * q) {
     mpf_ui_div(*d, p, *q);
}

void Rmpf_div_ui(mpf_t * d, mpf_t * p, unsigned long q) {
     mpf_div_ui(*d, *p, q);
}

void Rmpf_sqrt(mpf_t * r, mpf_t * x) {
     mpf_sqrt(*r, *x);
}

void Rmpf_sqrt_ui(mpf_t * r, unsigned long x) {
     mpf_sqrt_ui(*r, x);
}

void Rmpf_pow_ui(mpf_t * r, mpf_t * num, unsigned long pow) {
     mpf_pow_ui(*r, *num, pow);
}

void Rmpf_neg(mpf_t * r, mpf_t * x) {
     mpf_neg(*r, *x);
}

void Rmpf_abs(mpf_t * r, mpf_t * x) {
     mpf_abs(*r, *x);
}

void Rmpf_mul_2exp(pTHX_ mpf_t * r, mpf_t * x, SV * s) {
     mpf_mul_2exp(*r, *x, SvUV(s));
}

void Rmpf_div_2exp(pTHX_ mpf_t * r, mpf_t * x, SV * s) {
     mpf_div_2exp(*r, *x, SvUV(s));
}

int Rmpf_eq(mpf_t * a, mpf_t * b, unsigned long bits) {
     return mpf_eq(*a, *b, bits);
}

void Rmpf_reldiff(mpf_t * d, mpf_t * p, mpf_t * q){
     mpf_reldiff(*d, *p, *q);
}

int Rmpf_sgn(mpf_t * p) {
     return mpf_sgn(*p);
}

void Rmpf_ceil(mpf_t * p, mpf_t * q) {
     mpf_ceil(*p, *q);
}

void Rmpf_floor(mpf_t * p, mpf_t * q) {
     mpf_floor(*p, *q);
}

void Rmpf_trunc(mpf_t * p, mpf_t * q) {
     mpf_trunc(*p, *q);
}

int Rmpf_integer_p(mpf_t * p) {
     return mpf_integer_p(*p);
}

int Rmpf_fits_ulong_p(mpf_t * p) {
#if defined(__GNU_MP_RELEASE) && __GNU_MP_RELEASE > NEG_ZERO_BUG
     return mpf_fits_ulong_p(*p);
#else
     if((mpf_cmp_d(*p, -1.0) > 0) && (mpf_cmp_d(*p, 0) <= 0)) return 1;
     return mpf_fits_ulong_p(*p);
#endif
}

int Rmpf_fits_slong_p(mpf_t * p) {
     return mpf_fits_slong_p(*p);
}

int Rmpf_fits_uint_p(mpf_t * p) {
#if defined(__GNU_MP_RELEASE) && __GNU_MP_RELEASE > NEG_ZERO_BUG
     return mpf_fits_uint_p(*p);
#else
     if((mpf_cmp_d(*p, -1.0) > 0) && (mpf_cmp_d(*p, 0) <= 0)) return 1;
     return mpf_fits_uint_p(*p);
#endif
}

int Rmpf_fits_sint_p(mpf_t * p) {
     return mpf_fits_sint_p(*p);
}

int Rmpf_fits_ushort_p(mpf_t * p) {
#if defined(__GNU_MP_RELEASE) && __GNU_MP_RELEASE > NEG_ZERO_BUG
     return mpf_fits_ushort_p(*p);
#else
     if((mpf_cmp_d(*p, -1.0) > 0) && (mpf_cmp_d(*p, 0) <= 0)) return 1;
     return mpf_fits_ushort_p(*p);
#endif
}

int Rmpf_fits_sshort_p(mpf_t * p) {
     return mpf_fits_sshort_p(*p);
}

/* Finish typemapping - typemap 1st arg only */

SV * overload_mul(pTHX_ SV * a, SV * b, SV * third) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;
     const char *h;

     if(sv_isobject(b)) h = HvNAME(SvSTASH(SvRV(b)));

     if(!sv_isobject(b) || strNE(h, "Math::MPFR")) {
       New(1, mpf_t_obj, 1, mpf_t);
       if(mpf_t_obj == NULL) croak("Failed to allocate memory in overload_mul function");
       obj_ref = newSV(0);
       obj = newSVrv(obj_ref, "Math::GMPf");
       mpf_init(*mpf_t_obj);
       sv_setiv(obj, INT2PTR(IV, mpf_t_obj));
       SvREADONLY_on(obj);
     }

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_mul");
       mpf_mul(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }
#else
     if(SvUOK(b)) {
       mpf_mul_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
       return obj_ref;
     }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpf_mul_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
         return obj_ref;
       }
       mpf_mul_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvIVX(b) * -1);
       mpf_neg(*mpf_t_obj, *mpf_t_obj);
       return obj_ref;
     }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       _Rmpf_set_ld(aTHX_ mpf_t_obj, b);
#else
       mpf_set_d(*mpf_t_obj, SvNVX(b));
#endif
       mpf_mul(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(SvPOK(b)) {
       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_mul");
       mpf_mul(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(sv_isobject(b)) {
       if(strEQ(h, "Math::GMPf")) {
         mpf_mul(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         return obj_ref;
       }
       if(strEQ(h, "Math::MPFR")) {
         dSP;
         SV * ret;
         int count;

         ENTER;

         PUSHMARK(SP);
         XPUSHs(b);
         XPUSHs(a);
         XPUSHs(sv_2mortal(newSViv(1)));
         PUTBACK;

         count = call_pv("Math::MPFR::overload_mul", G_SCALAR);

         SPAGAIN;

         if (count != 1)
           croak("Error in Math::GMPf::overload_mul callback to Math::MPFR::overload_mul\n");

         ret = POPs;

         /* Avoid "Attempt to free unreferenced scalar" warning */
         SvREFCNT_inc(ret);
         LEAVE;
         return ret;
       }
     }

     croak("Invalid argument supplied to Math::GMPf::overload_mul");
}

SV * overload_add(pTHX_ SV * a, SV * b, SV * third) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;
     const char *h;

     if(sv_isobject(b)) h = HvNAME(SvSTASH(SvRV(b)));

     if(!sv_isobject(b) || strNE(h, "Math::MPFR")) {
       New(1, mpf_t_obj, 1, mpf_t);
       if(mpf_t_obj == NULL) croak("Failed to allocate memory in overload_add function");
       obj_ref = newSV(0);
       obj = newSVrv(obj_ref, "Math::GMPf");
       mpf_init(*mpf_t_obj);
       sv_setiv(obj, INT2PTR(IV, mpf_t_obj));
       SvREADONLY_on(obj);
     }

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_add");
       mpf_add(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }
#else
     if(SvUOK(b)) {
       mpf_add_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
       return obj_ref;
     }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpf_add_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
         return obj_ref;
       }
       mpf_sub_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvIVX(b) * -1);
       return obj_ref;
     }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       _Rmpf_set_ld(aTHX_ mpf_t_obj, b);
#else
       mpf_set_d(*mpf_t_obj, SvNVX(b));
#endif
       mpf_add(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(SvPOK(b)) {
       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_add");
       mpf_add(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(sv_isobject(b)) {
       if(strEQ(h, "Math::GMPf")) {
         mpf_add(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         return obj_ref;
       }
       if(strEQ(h, "Math::MPFR")) {
         dSP;
         SV * ret;
         int count;

         ENTER;

         PUSHMARK(SP);
         XPUSHs(b);
         XPUSHs(a);
         XPUSHs(sv_2mortal(newSViv(1)));
         PUTBACK;

         count = call_pv("Math::MPFR::overload_add", G_SCALAR);

         SPAGAIN;

         if (count != 1)
           croak("Error in Math::GMPf:overload_add callback to Math::MPFR::overload_add\n");

         ret = POPs;

         /* Avoid "Attempt to free unreferenced scalar" warning */
         SvREFCNT_inc(ret);
         LEAVE;
         return ret;
       }
     }

     croak("Invalid argument supplied to Math::GMPf::overload_add");
}

SV * overload_sub(pTHX_ SV * a, SV * b, SV * third) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;
     const char *h;

     if(sv_isobject(b)) h = HvNAME(SvSTASH(SvRV(b)));

     if(!sv_isobject(b) || strNE(h, "Math::MPFR")) {
       New(1, mpf_t_obj, 1, mpf_t);
       if(mpf_t_obj == NULL) croak("Failed to allocate memory in overload_sub function");
       obj_ref = newSV(0);
       obj = newSVrv(obj_ref, "Math::GMPf");
       mpf_init(*mpf_t_obj);
       sv_setiv(obj, INT2PTR(IV, mpf_t_obj));
       SvREADONLY_on(obj);
     }

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_sub");
       if(third == &PL_sv_yes) mpf_sub(*mpf_t_obj, *mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_sub(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }
#else
     if(SvUOK(b)) {
       if(third == &PL_sv_yes) mpf_ui_sub(*mpf_t_obj, SvUVX(b), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_sub_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
       return obj_ref;
     }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         if(third == &PL_sv_yes) mpf_ui_sub(*mpf_t_obj, SvUVX(b), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
         else mpf_sub_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
         return obj_ref;
       }
       mpf_add_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvIVX(b) * -1);
       if(third == &PL_sv_yes) mpf_neg(*mpf_t_obj, *mpf_t_obj);
       return obj_ref;
     }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       _Rmpf_set_ld(aTHX_ mpf_t_obj, b);
#else
       mpf_set_d(*mpf_t_obj, SvNVX(b));
#endif
       if(third == &PL_sv_yes) mpf_sub(*mpf_t_obj, *mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_sub(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(SvPOK(b)) {
       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_sub");
       if(third == &PL_sv_yes) mpf_sub(*mpf_t_obj, *mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_sub(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(sv_isobject(b)) {
       if(strEQ(h, "Math::GMPf")) {
         mpf_sub(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         return obj_ref;
       }
       if(strEQ(h, "Math::MPFR")) {
         dSP;
         SV * ret;
         int count;

         ENTER;

         PUSHMARK(SP);
         XPUSHs(b);
         XPUSHs(a);
         XPUSHs(sv_2mortal(&PL_sv_yes));
         PUTBACK;

         count = call_pv("Math::MPFR::overload_sub", G_SCALAR);

         SPAGAIN;

         if (count != 1)
           croak("Error in Math::GMPf:overload_sub callback to Math::MPFR::overload_sub\n");

         ret = POPs;

         /* Avoid "Attempt to free unreferenced scalar" warning */
         SvREFCNT_inc(ret);
         LEAVE;
         return ret;
       }
     }

     croak("Invalid argument supplied to Math::GMPf::overload_sub function");

}

SV * overload_div(pTHX_ SV * a, SV * b, SV * third) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;
     const char *h;

     if(sv_isobject(b)) h = HvNAME(SvSTASH(SvRV(b)));

     if(!sv_isobject(b) || strNE(h, "Math::MPFR")) {
       New(1, mpf_t_obj, 1, mpf_t);
       if(mpf_t_obj == NULL) croak("Failed to allocate memory in overload_div function");
       obj_ref = newSV(0);
       obj = newSVrv(obj_ref, "Math::GMPf");
       mpf_init(*mpf_t_obj);
       sv_setiv(obj, INT2PTR(IV, mpf_t_obj));
       SvREADONLY_on(obj);
     }

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_div");
       if(third == &PL_sv_yes) mpf_div(*mpf_t_obj, *mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_div(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }
#else
     if(SvUOK(b)) {
       if(third == &PL_sv_yes) mpf_ui_div(*mpf_t_obj, SvUVX(b), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_div_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
       return obj_ref;
     }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         if(third == &PL_sv_yes) mpf_ui_div(*mpf_t_obj, SvUVX(b), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
         else mpf_div_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
         return obj_ref;
       }
       if(third == &PL_sv_yes) mpf_ui_div(*mpf_t_obj, SvIVX(b) * -1, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_div_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvIVX(b) * -1);
       mpf_neg(*mpf_t_obj, *mpf_t_obj);
       return obj_ref;
     }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       _Rmpf_set_ld(aTHX_ mpf_t_obj, b);
#else
       mpf_set_d(*mpf_t_obj, SvNVX(b));
#endif
       if(third == &PL_sv_yes) mpf_div(*mpf_t_obj, *mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_div(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(SvPOK(b)) {
       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_div");
       if(third == &PL_sv_yes) mpf_div(*mpf_t_obj, *mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_div(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(sv_isobject(b)) {
       if(strEQ(h, "Math::GMPf")) {
         mpf_div(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         return obj_ref;
       }
       if(strEQ(h, "Math::MPFR")) {
         dSP;
         SV * ret;
         int count;

         ENTER;

         PUSHMARK(SP);
         XPUSHs(b);
         XPUSHs(a);
         XPUSHs(sv_2mortal(&PL_sv_yes));
         PUTBACK;

         count = call_pv("Math::MPFR::overload_div", G_SCALAR);

         SPAGAIN;

         if (count != 1)
           croak("Error in Math::GMPf::overload_div callback to Math::MPFR::overload_div\n");

         ret = POPs;

         /* Avoid "Attempt to free unreferenced scalar" warning */
         SvREFCNT_inc(ret);
         LEAVE;
         return ret;
       }
     }

     croak("Invalid argument supplied to Math::GMPf::overload_div function");

}

SV * overload_copy(pTHX_ mpf_t * p, SV * second, SV * third) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in overload_copy function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");

     mpf_init2(*mpf_t_obj, mpf_get_prec(*p));
     mpf_set(*mpf_t_obj, *p);
     sv_setiv(obj, INT2PTR(IV, mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_abs(pTHX_ mpf_t * p, SV * second, SV * third) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in overload_abs function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     mpf_init(*mpf_t_obj);

     mpf_abs(*mpf_t_obj, *p);
     sv_setiv(obj, INT2PTR(IV, mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_gt(pTHX_ mpf_t * a, SV * b, SV * third) {
     mpf_t t;
     int ret;


#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_gt");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvUOK(b)) {
       ret = mpf_cmp_ui(*a, SvUVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpf_cmp_si(*a, SvIVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_gt");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         ret = mpf_cmp(*a, *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         if(ret > 0) return newSViv(1);
         return newSViv(0);
         }
       }

     croak("Invalid argument supplied to Math::GMPf::overload_gt");
}

SV * overload_gte(pTHX_ mpf_t * a, SV * b, SV * third) {
     mpf_t t;
     int ret;

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_gte");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvUOK(b)) {
       ret = mpf_cmp_ui(*a, SvUVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpf_cmp_si(*a, SvIVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_gte");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         ret = mpf_cmp(*a, *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         if(ret >= 0) return newSViv(1);
         return newSViv(0);
         }
       }

     croak("Invalid argument supplied to Math::GMPf::overload_gte");
}

SV * overload_lt(pTHX_ mpf_t * a, SV * b, SV * third) {
     mpf_t t;
     int ret;

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_lt");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvUOK(b)) {
       ret = mpf_cmp_ui(*a, SvUVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpf_cmp_si(*a, SvIVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_lt");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         ret = mpf_cmp(*a, *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         if(ret < 0) return newSViv(1);
         return newSViv(0);
         }
       }

     croak("Invalid argument supplied to Math::GMPf::overload_lt");
}

SV * overload_lte(pTHX_ mpf_t * a, SV * b, SV * third) {
     mpf_t t;
     int ret;

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_lte");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvUOK(b)) {
       ret = mpf_cmp_ui(*a, SvUVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpf_cmp_si(*a, SvIVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_lte");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         ret = mpf_cmp(*a, *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         if(ret <= 0) return newSViv(1);
         return newSViv(0);
         }
       }

     croak("Invalid argument supplied to Math::GMPf::overload_lte");
}

SV * overload_spaceship(pTHX_ mpf_t * a, SV * b, SV * third) {
     mpf_t t;
     int ret;

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_spaceship");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvUOK(b)) {
       ret = mpf_cmp_ui(*a, SvUVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpf_cmp_si(*a, SvIVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_spaceship");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         ret = mpf_cmp(*a, *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         if(ret < 0) return newSViv(-1);
         if(ret > 0) return newSViv(1);
         return newSViv(0);
         }
       }

     croak("Invalid argument supplied to Math::GMPf::overload_spaceship");
}

SV * overload_equiv(pTHX_ mpf_t * a, SV * b, SV * third) {
     mpf_t t;
     int ret;

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_equiv");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvUOK(b)) {
       ret = mpf_cmp_ui(*a, SvUVX(b));
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvIOK(b)) {
       ret = mpf_cmp_si(*a, SvIVX(b));
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_equiv");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(ret == 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         ret = mpf_cmp(*a, *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         if(ret == 0) return newSViv(1);
         return newSViv(0);
         }
       }

     croak("Invalid argument supplied to Math::GMPf::overload_equiv");
}

SV * overload_not_equiv(pTHX_ mpf_t * a, SV * b, SV * third) {
     mpf_t t;
     int ret;

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_not_equiv");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }
#else
     if(SvUOK(b)) {
       ret = mpf_cmp_ui(*a, SvUVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }
     if(SvIOK(b)) {
       ret = mpf_cmp_si(*a, SvIVX(b));
       if(third == &PL_sv_yes) ret *= -1;
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string supplied to Math::GMPf::overload_not_equiv");
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret != 0) return newSViv(1);
       return newSViv(0);
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         ret = mpf_cmp(*a, *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         if(ret != 0) return newSViv(1);
         return newSViv(0);
         }
       }

     croak("Invalid argument supplied to Math::GMPf::overload_not_equiv");
}

SV * overload_not(pTHX_ mpf_t * a, SV * second, SV * third) {
     if(mpf_cmp_ui(*a, 0)) return newSViv(0);
     return newSViv(1);
}

SV * overload_sqrt(pTHX_ mpf_t * p, SV * second, SV * third) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in overload_sqrt function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     mpf_init(*mpf_t_obj);

     if(mpf_cmp_ui(*p, 0) < 0) croak("Negative value supplied as argument to overload_sqrt");
     mpf_sqrt(*mpf_t_obj, *p);
     sv_setiv(obj, INT2PTR(IV, mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

SV * overload_pow(pTHX_ SV * p, SV * second, SV * third) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     if(!sv_isobject(second)) {
       New(1, mpf_t_obj, 1, mpf_t);
       if(mpf_t_obj == NULL) croak("Failed to allocate memory in overload_sqrt function");
       obj_ref = newSV(0);
       obj = newSVrv(obj_ref, "Math::GMPf");
       mpf_init(*mpf_t_obj);
       sv_setiv(obj, INT2PTR(IV, mpf_t_obj));
       SvREADONLY_on(obj);
     }

     if(SvUOK(second)) {
       mpf_pow_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(p)))), SvUV(second));
       return obj_ref;
     }

     if(SvIOK(second)) {
       if(SvIV(second) >= 0) {
         mpf_pow_ui(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(p)))), SvUV(second));
         return obj_ref;
       }
     }

     if(sv_isobject(second)) {
       const char * h = HvNAME(SvSTASH(SvRV(second)));
       if(strEQ(h, "Math::MPFR")) {
         dSP;
         SV * ret;
         int count;

         ENTER;

         PUSHMARK(SP);
         XPUSHs(second);
         XPUSHs(p);
         XPUSHs(sv_2mortal(&PL_sv_yes));
         PUTBACK;

         count = call_pv("Math::MPFR::overload_pow", G_SCALAR);

         SPAGAIN;

         if (count != 1)
           croak("Error in Math::GMPf:overload_pow callback to Math::MPFR::overload_pow\n");

         ret = POPs;

         /* Avoid "Attempt to free unreferenced scalar" warning */
         SvREFCNT_inc(ret);
         LEAVE;
         return ret;
       }
     }

     croak("Invalid argument supplied to Math::GMPf::overload_pow. The function handles only unsigned longs and Math::MPFR objects as exponents.");
}

SV * overload_int(pTHX_ mpf_t * p, SV * second, SV * third) {
     mpf_t * mpf_t_obj;
     SV * obj_ref, * obj;

     New(1, mpf_t_obj, 1, mpf_t);
     if(mpf_t_obj == NULL) croak("Failed to allocate memory in overload_int function");
     obj_ref = newSV(0);
     obj = newSVrv(obj_ref, "Math::GMPf");
     mpf_init(*mpf_t_obj);

     mpf_trunc(*mpf_t_obj, *p);
     sv_setiv(obj, INT2PTR(IV, mpf_t_obj));
     SvREADONLY_on(obj);
     return obj_ref;
}

/* Finish typemapping */

void Rmpf_urandomb(pTHX_ SV * p, ...) {
     dXSARGS;
     unsigned long q, i, thingies;

     thingies = items;
     q = SvUV(ST(thingies - 1));

     if((q + 3) != thingies) croak ("Wrong args supplied to mpf_urandomb function");

     for(i = 0; i < q; ++i) {
        mpf_urandomb(*(INT2PTR(mpf_t *, SvIVX(SvRV(ST(i))))), *(INT2PTR(gmp_randstate_t *, SvIVX(SvRV(ST(thingies - 3))))), SvUV(ST(thingies - 2)));
        }

     XSRETURN(0);
}

void Rmpf_random2(pTHX_ SV * x, ...){
     dXSARGS;
     unsigned long q, i, thingies;

     thingies = items;
     q = SvUV(ST(thingies - 1));

     if((q + 3) != thingies) croak ("Wrong args supplied to mpf_random2 function");

     for(i = 0; i < q; ++i) {
        mpf_random2(*(INT2PTR(mpf_t *, SvIVX(SvRV(ST(i))))), SvIV(ST(thingies - 3)), SvUV(ST(thingies - 2)));
        }

     XSRETURN(0);
}

SV * get_refcnt(pTHX_ SV * s) {
     return newSVuv(SvREFCNT(s));
}

SV * overload_mul_eq(pTHX_ SV * a, SV * b, SV * third) {
     mpf_t t;

     SvREFCNT_inc(a);


#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::GMPf::overload_mul_eq");
         }
       mpf_mul(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }
#else
     if(SvUOK(b)) {
       mpf_mul_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpf_mul_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
         return a;
         }
       mpf_mul_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvIVX(b) * -1);
       mpf_neg(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       return a;
       }
#endif


     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       mpf_mul(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::GMPf::overload_mul_eq");
         }
       mpf_mul(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         mpf_mul(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to Math::GMPf::overload_mul_eq");
}

SV * overload_add_eq(pTHX_ SV * a, SV * b, SV * third) {
     mpf_t t;

     SvREFCNT_inc(a);

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::GMPf::overload_add_eq");
         }
       mpf_add(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }
#else
     if(SvUOK(b)) {
       mpf_add_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpf_add_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
         return a;
         }
       mpf_sub_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvIVX(b) * -1);
       return a;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       mpf_add(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::GMPf::overload_add_eq");
         }
       mpf_add(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         mpf_add(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to Math::GMPf::overload_add_eq");
}

SV * overload_sub_eq(pTHX_ SV * a, SV * b, SV * third) {
     mpf_t t;

     SvREFCNT_inc(a);

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::GMPf::overload_sub_eq");
         }
       mpf_sub(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }
#else
     if(SvUOK(b)) {
       mpf_sub_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpf_sub_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
         return a;
         }
       mpf_add_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvIVX(b) * -1);
       return a;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       mpf_sub(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::GMPf::overload_sub_eq");
         }
       mpf_sub(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         mpf_sub(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to Math::GMPf::overload_sub_eq function");

}

SV * overload_div_eq(pTHX_ SV * a, SV * b, SV * third) {
     mpf_t t;

     SvREFCNT_inc(a);

#ifdef MATH_GMPF_NEED_LONG_LONG_INT
     if(SvIOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::GMPf::overload_div_eq");
         }
       mpf_div(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }
#else
     if(SvUOK(b)) {
       mpf_div_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
       return a;
       }

     if(SvIOK(b)) {
       if(SvIV(b) >= 0) {
         mpf_div_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvUVX(b));
         return a;
         }
       mpf_div_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), SvIVX(b) * -1);
       mpf_neg(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       return a;
       }
#endif

     if(SvNOK(b)) {
#ifdef USE_LONG_DOUBLE
       mpf_init(t);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init_set_d(t, SvNVX(b));
#endif
       mpf_div(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }

     if(SvPOK(b)) {
       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string supplied to Math::GMPf::overload_div_eq");
         }
       mpf_div(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
       }

     if(sv_isobject(b)) {
       const char * h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPf")) {
         mpf_div(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         return a;
         }
       }

     SvREFCNT_dec(a);
     croak("Invalid argument supplied to Math::GMPf::overload_div_eq function");

}

SV * overload_pow_eq(pTHX_ SV * p, SV * second, SV * third) {

     SvREFCNT_inc(p);

     if(SvUOK(second)) {
       mpf_pow_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(p)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(p)))), SvUV(second));
       return p;
       }

     if(SvIOK(second)) {
       if(SvIV(second) >= 0) {
         mpf_pow_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(p)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(p)))), SvUV(second));
         return p;
         }
       }

     SvREFCNT_dec(p);
     croak("Invalid argument supplied to Math::GMPf::overload_pow_eq. The function handles only positive 'unsigned long' exponents.");
}

SV * gmp_v(pTHX) {
#if __GNU_MP_VERSION >= 4
     return newSVpv(gmp_version, 0);
#else
     warn("From Math::GMPf::gmp_v(aTHX): 'gmp_version' is not implemented - returning '0'");
     return newSVpv("0", 0);
#endif
}

SV * wrap_gmp_printf(pTHX_ SV * a, SV * b) {
     int ret;
     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPz") ||
         strEQ(h, "Math::GMP") ||
         strEQ(h, "GMP::Mpz")) {
         ret = gmp_printf(SvPV_nolen(a), *(INT2PTR(mpz_t *, SvIVX(SvRV(b)))));
         fflush(stdout);
         return newSViv(ret);
       }
       if(strEQ(h, "Math::GMPq") ||
         strEQ(h, "GMP::Mpq")) {
         ret = gmp_printf(SvPV_nolen(a), *(INT2PTR(mpq_t *, SvIVX(SvRV(b)))));
         fflush(stdout);
         return newSViv(ret);
       }
       if(strEQ(h, "Math::GMPf") ||
         strEQ(h, "GMP::Mpf")) {
         ret = gmp_printf(SvPV_nolen(a), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         fflush(stdout);
         return newSViv(ret);
       }

       croak("Unrecognised object supplied as argument to Rmpf_printf");
     }

     if(SvUOK(b)) {
       ret = gmp_printf(SvPV_nolen(a), SvUVX(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvIOK(b)) {
       ret = gmp_printf(SvPV_nolen(a), SvIVX(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvNOK(b)) {
       ret = gmp_printf(SvPV_nolen(a), SvNVX(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvPOK(b)) {
       ret = gmp_printf(SvPV_nolen(a), SvPV_nolen(b));
       fflush(stdout);
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpf_printf");
}

SV * wrap_gmp_fprintf(pTHX_ FILE * stream, SV * a, SV * b) {
     int ret;
     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPz") ||
         strEQ(h, "Math::GMP") ||
         strEQ(h, "GMP::Mpz")) {
         ret = gmp_fprintf(stream, SvPV_nolen(a), *(INT2PTR(mpz_t *, SvIVX(SvRV(b)))));
         fflush(stream);
         return newSViv(ret);
       }
       if(strEQ(h, "Math::GMPq") ||
         strEQ(h, "GMP::Mpq")) {
         ret = gmp_fprintf(stream, SvPV_nolen(a), *(INT2PTR(mpq_t *, SvIVX(SvRV(b)))));
         fflush(stream);
         return newSViv(ret);
       }
       if(strEQ(h, "Math::GMPf") ||
         strEQ(h, "GMP::Mpf")) {
         ret = gmp_fprintf(stream, SvPV_nolen(a), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         fflush(stream);
         return newSViv(ret);
       }

       else croak("Unrecognised object supplied as argument to Rmpf_fprintf");
     }

     if(SvUOK(b)) {
       ret = gmp_fprintf(stream, SvPV_nolen(a), SvUVX(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvIOK(b)) {
       ret = gmp_fprintf(stream, SvPV_nolen(a), SvIVX(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvNOK(b)) {
       ret = gmp_fprintf(stream, SvPV_nolen(a), SvNVX(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvPOK(b)) {
       ret = gmp_fprintf(stream, SvPV_nolen(a), SvPV_nolen(b));
       fflush(stream);
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpf_fprintf");
}

SV * wrap_gmp_sprintf(pTHX_ SV * s, SV * a, SV * b, int buflen) {
     int ret;
     char * stream;

     Newx(stream, buflen, char);

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPz") ||
         strEQ(h, "Math::GMP") ||
         strEQ(h, "GMP::Mpz")) {
         ret = gmp_sprintf(stream, SvPV_nolen(a), *(INT2PTR(mpz_t *, SvIVX(SvRV(b)))));
         sv_setpv(s, stream);
         Safefree(stream);
         return newSViv(ret);
       }

       if(strEQ(h, "Math::GMPq") ||
         strEQ(h, "GMP::Mpq")) {
         ret = gmp_sprintf(stream, SvPV_nolen(a), *(INT2PTR(mpq_t *, SvIVX(SvRV(b)))));
         sv_setpv(s, stream);
         Safefree(stream);
         return newSViv(ret);
       }

       if(strEQ(h, "Math::GMPf") ||
         strEQ(h, "GMP::Mpf")) {
         ret = gmp_sprintf(stream, SvPV_nolen(a), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         sv_setpv(s, stream);
         Safefree(stream);
         return newSViv(ret);
       }

       croak("Unrecognised object supplied as argument to Rmpf_sprintf");
     }

     if(SvUOK(b)) {
       ret = gmp_sprintf(stream, SvPV_nolen(a), SvUVX(b));
       sv_setpv(s, stream);
       Safefree(stream);
       return newSViv(ret);
     }

     if(SvIOK(b)) {
       ret = gmp_sprintf(stream, SvPV_nolen(a), SvIVX(b));
       sv_setpv(s, stream);
       Safefree(stream);
       return newSViv(ret);
     }

     if(SvNOK(b)) {
       ret = gmp_sprintf(stream, SvPV_nolen(a), SvNVX(b));
       sv_setpv(s, stream);
       Safefree(stream);
       return newSViv(ret);
     }

     if(SvPOK(b)) {
       ret = gmp_sprintf(stream, SvPV_nolen(a), SvPV_nolen(b));
       sv_setpv(s, stream);
       Safefree(stream);
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpf_sprintf");
}

SV * wrap_gmp_snprintf(pTHX_ SV * s, SV * bytes, SV * a, SV * b, int buflen) {
     int ret;
     char * stream;

     Newx(stream, buflen, char);

     if(sv_isobject(b)) {
       const char *h = HvNAME(SvSTASH(SvRV(b)));
       if(strEQ(h, "Math::GMPz") ||
         strEQ(h, "Math::GMP") ||
         strEQ(h, "GMP::Mpz")) {
         ret = gmp_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), *(INT2PTR(mpz_t *, SvIVX(SvRV(b)))));
         sv_setpv(s, stream);
         Safefree(stream);
         return newSViv(ret);
       }

       if(strEQ(h, "Math::GMPq") ||
         strEQ(h, "GMP::Mpq")) {
         ret = gmp_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), *(INT2PTR(mpq_t *, SvIVX(SvRV(b)))));
         sv_setpv(s, stream);
         Safefree(stream);
         return newSViv(ret);
       }

       if(strEQ(h, "Math::GMPf") ||
         strEQ(h, "GMP::Mpf")) {
         ret = gmp_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), *(INT2PTR(mpf_t *, SvIVX(SvRV(b)))));
         sv_setpv(s, stream);
         Safefree(stream);
         return newSViv(ret);
       }

       croak("Unrecognised object supplied as argument to Rmpf_snprintf");
     }

     if(SvUOK(b)) {
       ret = gmp_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), SvUVX(b));
       sv_setpv(s, stream);
       Safefree(stream);;
       return newSViv(ret);
     }

     if(SvIOK(b)) {
       ret = gmp_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), SvIVX(b));
       sv_setpv(s, stream);
       Safefree(stream);
       return newSViv(ret);
     }

     if(SvNOK(b)) {
       ret = gmp_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), SvNVX(b));
       sv_setpv(s, stream);
       Safefree(stream);
       return newSViv(ret);
     }

     if(SvPOK(b)) {
       ret = gmp_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), SvPV_nolen(b));
       sv_setpv(s, stream);
       Safefree(stream);
       return newSViv(ret);
     }

     croak("Unrecognised type supplied as argument to Rmpf_snprintf");
}

int _itsa(pTHX_ SV * a) {
     if(SvUOK(a)) return 1;
     if(SvIOK(a)) return 2;
     if(SvNOK(a)) return 3;
     if(SvPOK(a)) return 4;
     if(sv_isobject(a)) {
       const char *h = HvNAME(SvSTASH(SvRV(a)));
       if(strEQ(h, "Math::GMPf")) return 6;
     }
     return 0;
}


int _has_longlong(void) {
#ifdef MATH_GMPF_NEED_LONG_LONG_INT
    return 1;
#else
    return 0;
#endif
}

int _has_longdouble(void) {
#ifdef USE_LONG_DOUBLE
    return 1;
#else
    return 0;
#endif
}

/* Has inttypes.h been included ? */
int _has_inttypes(void) {
#ifdef _MSC_VER
return 0;
#else
#if defined MATH_GMPF_NEED_LONG_LONG_INT
return 1;
#else
return 0;
#endif
#endif
}

SV * ___GNU_MP_VERSION(pTHX) {
     return newSVuv(__GNU_MP_VERSION);
}

SV * ___GNU_MP_VERSION_MINOR(pTHX) {
     return newSVuv(__GNU_MP_VERSION_MINOR);
}

SV * ___GNU_MP_VERSION_PATCHLEVEL(pTHX) {
     return newSVuv(__GNU_MP_VERSION_PATCHLEVEL);
}

SV * ___GNU_MP_RELEASE(pTHX) {
#if defined(__GNU_MP_RELEASE)
     return newSVuv(__GNU_MP_RELEASE);
#else
     return &PL_sv_undef;
#endif
}

SV * ___GMP_CC(pTHX) {
#ifdef __GMP_CC
     char * ret = __GMP_CC;
     return newSVpv(ret, 0);
#else
     return &PL_sv_undef;
#endif
}

SV * ___GMP_CFLAGS(pTHX) {
#ifdef __GMP_CFLAGS
     char * ret = __GMP_CFLAGS;
     return newSVpv(ret, 0);
#else
     return &PL_sv_undef;
#endif
}

SV * overload_inc(pTHX_ SV * p, SV * second, SV * third) {
     SvREFCNT_inc(p);
     mpf_add_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(p)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(p)))), 1);
     return p;
}

SV * overload_dec(pTHX_ SV * p, SV * second, SV * third) {
     SvREFCNT_inc(p);
     mpf_sub_ui(*(INT2PTR(mpf_t *, SvIVX(SvRV(p)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(p)))),1);
     return p;
}

SV * _wrap_count(pTHX) {
     return newSVuv(PL_sv_count);
}

SV * _get_xs_version(pTHX) {
     return newSVpv(XS_VERSION, 0);
}

SV * _GMP_LIMB_BITS(pTHX) {
#ifdef GMP_LIMB_BITS
     return newSVuv(GMP_LIMB_BITS);
#else
     return &PL_sv_undef;
#endif
}

SV * _GMP_NAIL_BITS(pTHX) {
#ifdef GMP_NAIL_BITS
     return newSVuv(GMP_NAIL_BITS);
#else
     return &PL_sv_undef;
#endif
}
MODULE = Math::GMPf  PACKAGE = Math::GMPf

PROTOTYPES: DISABLE


unsigned long
Rmpf_get_default_prec ()


void
Rmpf_set_default_prec (prec)
	SV *	prec
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_default_prec(aTHX_ prec);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SV *
Rmpf_init_set_str_nobless (str, base)
	SV *	str
	SV *	base
CODE:
  RETVAL = Rmpf_init_set_str_nobless (aTHX_ str, base);
OUTPUT:  RETVAL

SV *
Rmpf_init2_nobless (prec)
	SV *	prec
CODE:
  RETVAL = Rmpf_init2_nobless (aTHX_ prec);
OUTPUT:  RETVAL

SV *
Rmpf_init_set_str (str, base)
	SV *	str
	SV *	base
CODE:
  RETVAL = Rmpf_init_set_str (aTHX_ str, base);
OUTPUT:  RETVAL

SV *
Rmpf_init2 (prec)
	SV *	prec
CODE:
  RETVAL = Rmpf_init2 (aTHX_ prec);
OUTPUT:  RETVAL

SV *
Rmpf_init_nobless ()
CODE:
  RETVAL = Rmpf_init_nobless (aTHX);
OUTPUT:  RETVAL


SV *
Rmpf_init ()
CODE:
  RETVAL = Rmpf_init (aTHX);
OUTPUT:  RETVAL


SV *
Rmpf_init_set (a)
	mpf_t *	a
CODE:
  RETVAL = Rmpf_init_set (aTHX_ a);
OUTPUT:  RETVAL

SV *
Rmpf_init_set_ui (a)
	unsigned long	a
CODE:
  RETVAL = Rmpf_init_set_ui (aTHX_ a);
OUTPUT:  RETVAL

SV *
Rmpf_init_set_si (a)
	long	a
CODE:
  RETVAL = Rmpf_init_set_si (aTHX_ a);
OUTPUT:  RETVAL

SV *
Rmpf_init_set_d (a)
	double	a
CODE:
  RETVAL = Rmpf_init_set_d (aTHX_ a);
OUTPUT:  RETVAL

void
_Rmpf_set_ld (q, p)
	mpf_t *	q
	SV *	p
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        _Rmpf_set_ld(aTHX_ q, p);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SV *
Rmpf_init_set_nobless (a)
	mpf_t *	a
CODE:
  RETVAL = Rmpf_init_set_nobless (aTHX_ a);
OUTPUT:  RETVAL

SV *
Rmpf_init_set_ui_nobless (a)
	unsigned long	a
CODE:
  RETVAL = Rmpf_init_set_ui_nobless (aTHX_ a);
OUTPUT:  RETVAL

SV *
Rmpf_init_set_si_nobless (a)
	long	a
CODE:
  RETVAL = Rmpf_init_set_si_nobless (aTHX_ a);
OUTPUT:  RETVAL

SV *
Rmpf_init_set_d_nobless (a)
	double	a
CODE:
  RETVAL = Rmpf_init_set_d_nobless (aTHX_ a);
OUTPUT:  RETVAL

void
Rmpf_deref2 (p, base, n_digits)
	mpf_t *	p
	SV *	base
	SV *	n_digits
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_deref2(aTHX_ p, base, n_digits);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
DESTROY (p)
	mpf_t *	p
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        DESTROY(aTHX_ p);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_clear (p)
	mpf_t *	p
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_clear(aTHX_ p);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_clear_mpf (p)
	mpf_t *	p
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_clear_mpf(aTHX_ p);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_clear_ptr (p)
	mpf_t *	p
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_clear_ptr(aTHX_ p);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SV *
Rmpf_get_prec (p)
	mpf_t *	p
CODE:
  RETVAL = Rmpf_get_prec (aTHX_ p);
OUTPUT:  RETVAL

void
Rmpf_set_prec (p, prec)
	mpf_t *	p
	SV *	prec
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_prec(aTHX_ p, prec);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_set_prec_raw (p, prec)
	mpf_t *	p
	SV *	prec
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_prec_raw(aTHX_ p, prec);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_set (p1, p2)
	mpf_t *	p1
	mpf_t *	p2
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set(p1, p2);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_set_ui (p, ul)
	mpf_t *	p
	unsigned long	ul
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_ui(p, ul);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_set_si (p, l)
	mpf_t *	p
	long	l
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_si(p, l);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_set_d (p, d)
	mpf_t *	p
	double	d
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_d(p, d);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_set_z (p, z)
	mpf_t *	p
	mpz_t *	z
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_z(p, z);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_set_q (p, q)
	mpf_t *	p
	mpq_t *	q
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_q(p, q);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_set_str (p, str, base)
	mpf_t *	p
	SV *	str
	int	base
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_str(aTHX_ p, str, base);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_swap (p1, p2)
	mpf_t *	p1
	mpf_t *	p2
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_swap(p1, p2);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SV *
_TRmpf_out_str (stream, base, dig, p)
	FILE *	stream
	int	base
	SV *	dig
	mpf_t *	p
CODE:
  RETVAL = _TRmpf_out_str (aTHX_ stream, base, dig, p);
OUTPUT:  RETVAL

SV *
_Rmpf_out_str (p, base, dig)
	mpf_t *	p
	int	base
	SV *	dig
CODE:
  RETVAL = _Rmpf_out_str (aTHX_ p, base, dig);
OUTPUT:  RETVAL

SV *
_TRmpf_out_strS (stream, base, dig, p, suff)
	FILE *	stream
	int	base
	SV *	dig
	mpf_t *	p
	SV *	suff
CODE:
  RETVAL = _TRmpf_out_strS (aTHX_ stream, base, dig, p, suff);
OUTPUT:  RETVAL

SV *
_TRmpf_out_strP (pre, stream, base, dig, p)
	SV *	pre
	FILE *	stream
	int	base
	SV *	dig
	mpf_t *	p
CODE:
  RETVAL = _TRmpf_out_strP (aTHX_ pre, stream, base, dig, p);
OUTPUT:  RETVAL

SV *
_TRmpf_out_strPS (pre, stream, base, dig, p, suff)
	SV *	pre
	FILE *	stream
	int	base
	SV *	dig
	mpf_t *	p
	SV *	suff
CODE:
  RETVAL = _TRmpf_out_strPS (aTHX_ pre, stream, base, dig, p, suff);
OUTPUT:  RETVAL

SV *
_Rmpf_out_strS (p, base, dig, suff)
	mpf_t *	p
	int	base
	SV *	dig
	SV *	suff
CODE:
  RETVAL = _Rmpf_out_strS (aTHX_ p, base, dig, suff);
OUTPUT:  RETVAL

SV *
_Rmpf_out_strP (pre, p, base, dig)
	SV *	pre
	mpf_t *	p
	int	base
	SV *	dig
CODE:
  RETVAL = _Rmpf_out_strP (aTHX_ pre, p, base, dig);
OUTPUT:  RETVAL

SV *
_Rmpf_out_strPS (pre, p, base, dig, suff)
	SV *	pre
	mpf_t *	p
	int	base
	SV *	dig
	SV *	suff
CODE:
  RETVAL = _Rmpf_out_strPS (aTHX_ pre, p, base, dig, suff);
OUTPUT:  RETVAL

SV *
TRmpf_inp_str (p, stream, base)
	mpf_t *	p
	FILE *	stream
	int	base
CODE:
  RETVAL = TRmpf_inp_str (aTHX_ p, stream, base);
OUTPUT:  RETVAL

SV *
Rmpf_inp_str (p, base)
	mpf_t *	p
	int	base
CODE:
  RETVAL = Rmpf_inp_str (aTHX_ p, base);
OUTPUT:  RETVAL

int
Rmpf_cmp (p1, p2)
	mpf_t *	p1
	mpf_t *	p2

int
Rmpf_cmp_ui (p, ul)
	mpf_t *	p
	unsigned long	ul

int
Rmpf_cmp_si (p, l)
	mpf_t *	p
	long	l

int
Rmpf_cmp_d (p, d)
	mpf_t *	p
	double	d

double
Rmpf_get_d (p)
	mpf_t *	p

long
Rmpf_get_si (p)
	mpf_t *	p

unsigned long
Rmpf_get_ui (p)
	mpf_t *	p

void
Rmpf_get_d_2exp (n)
	mpf_t *	n
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_get_d_2exp(aTHX_ n);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_add (dest, src1, src2)
	mpf_t *	dest
	mpf_t *	src1
	mpf_t *	src2
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_add(dest, src1, src2);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_add_ui (dest, src, num)
	mpf_t *	dest
	mpf_t *	src
	unsigned long	num
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_add_ui(dest, src, num);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_sub (dest, src1, src2)
	mpf_t *	dest
	mpf_t *	src1
	mpf_t *	src2
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_sub(dest, src1, src2);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_sub_ui (dest, src, num)
	mpf_t *	dest
	mpf_t *	src
	unsigned long	num
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_sub_ui(dest, src, num);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_ui_sub (dest, num, src)
	mpf_t *	dest
	unsigned long	num
	mpf_t *	src
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_ui_sub(dest, num, src);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_mul (dest, src1, src2)
	mpf_t *	dest
	mpf_t *	src1
	mpf_t *	src2
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_mul(dest, src1, src2);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_mul_ui (dest, src, num)
	mpf_t *	dest
	mpf_t *	src
	unsigned long	num
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_mul_ui(dest, src, num);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_div (d, p, q)
	mpf_t *	d
	mpf_t *	p
	mpf_t *	q
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_div(d, p, q);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_ui_div (d, p, q)
	mpf_t *	d
	unsigned long	p
	mpf_t *	q
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_ui_div(d, p, q);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_div_ui (d, p, q)
	mpf_t *	d
	mpf_t *	p
	unsigned long	q
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_div_ui(d, p, q);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_sqrt (r, x)
	mpf_t *	r
	mpf_t *	x
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_sqrt(r, x);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_sqrt_ui (r, x)
	mpf_t *	r
	unsigned long	x
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_sqrt_ui(r, x);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_pow_ui (r, num, pow)
	mpf_t *	r
	mpf_t *	num
	unsigned long	pow
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_pow_ui(r, num, pow);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_neg (r, x)
	mpf_t *	r
	mpf_t *	x
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_neg(r, x);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_abs (r, x)
	mpf_t *	r
	mpf_t *	x
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_abs(r, x);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_mul_2exp (r, x, s)
	mpf_t *	r
	mpf_t *	x
	SV *	s
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_mul_2exp(aTHX_ r, x, s);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_div_2exp (r, x, s)
	mpf_t *	r
	mpf_t *	x
	SV *	s
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_div_2exp(aTHX_ r, x, s);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

int
Rmpf_eq (a, b, bits)
	mpf_t *	a
	mpf_t *	b
	unsigned long	bits

void
Rmpf_reldiff (d, p, q)
	mpf_t *	d
	mpf_t *	p
	mpf_t *	q
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_reldiff(d, p, q);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

int
Rmpf_sgn (p)
	mpf_t *	p

void
Rmpf_ceil (p, q)
	mpf_t *	p
	mpf_t *	q
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_ceil(p, q);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_floor (p, q)
	mpf_t *	p
	mpf_t *	q
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_floor(p, q);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_trunc (p, q)
	mpf_t *	p
	mpf_t *	q
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_trunc(p, q);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

int
Rmpf_integer_p (p)
	mpf_t *	p

int
Rmpf_fits_ulong_p (p)
	mpf_t *	p

int
Rmpf_fits_slong_p (p)
	mpf_t *	p

int
Rmpf_fits_uint_p (p)
	mpf_t *	p

int
Rmpf_fits_sint_p (p)
	mpf_t *	p

int
Rmpf_fits_ushort_p (p)
	mpf_t *	p

int
Rmpf_fits_sshort_p (p)
	mpf_t *	p

SV *
overload_mul (a, b, third)
	SV *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_mul (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_add (a, b, third)
	SV *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_add (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_sub (a, b, third)
	SV *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_sub (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_div (a, b, third)
	SV *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_div (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_copy (p, second, third)
	mpf_t *	p
	SV *	second
	SV *	third
CODE:
  RETVAL = overload_copy (aTHX_ p, second, third);
OUTPUT:  RETVAL

SV *
overload_abs (p, second, third)
	mpf_t *	p
	SV *	second
	SV *	third
CODE:
  RETVAL = overload_abs (aTHX_ p, second, third);
OUTPUT:  RETVAL

SV *
overload_gt (a, b, third)
	mpf_t *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_gt (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_gte (a, b, third)
	mpf_t *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_gte (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_lt (a, b, third)
	mpf_t *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_lt (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_lte (a, b, third)
	mpf_t *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_lte (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_spaceship (a, b, third)
	mpf_t *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_spaceship (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_equiv (a, b, third)
	mpf_t *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_equiv (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_not_equiv (a, b, third)
	mpf_t *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_not_equiv (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_not (a, second, third)
	mpf_t *	a
	SV *	second
	SV *	third
CODE:
  RETVAL = overload_not (aTHX_ a, second, third);
OUTPUT:  RETVAL

SV *
overload_sqrt (p, second, third)
	mpf_t *	p
	SV *	second
	SV *	third
CODE:
  RETVAL = overload_sqrt (aTHX_ p, second, third);
OUTPUT:  RETVAL

SV *
overload_pow (p, second, third)
	SV *	p
	SV *	second
	SV *	third
CODE:
  RETVAL = overload_pow (aTHX_ p, second, third);
OUTPUT:  RETVAL

SV *
overload_int (p, second, third)
	mpf_t *	p
	SV *	second
	SV *	third
CODE:
  RETVAL = overload_int (aTHX_ p, second, third);
OUTPUT:  RETVAL

void
Rmpf_urandomb (p, ...)
	SV *	p
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_urandomb(aTHX_ p);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
Rmpf_random2 (x, ...)
	SV *	x
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_random2(aTHX_ x);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SV *
get_refcnt (s)
	SV *	s
CODE:
  RETVAL = get_refcnt (aTHX_ s);
OUTPUT:  RETVAL

SV *
overload_mul_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_mul_eq (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_add_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_add_eq (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_sub_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_sub_eq (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_div_eq (a, b, third)
	SV *	a
	SV *	b
	SV *	third
CODE:
  RETVAL = overload_div_eq (aTHX_ a, b, third);
OUTPUT:  RETVAL

SV *
overload_pow_eq (p, second, third)
	SV *	p
	SV *	second
	SV *	third
CODE:
  RETVAL = overload_pow_eq (aTHX_ p, second, third);
OUTPUT:  RETVAL

SV *
gmp_v ()
CODE:
  RETVAL = gmp_v (aTHX);
OUTPUT:  RETVAL


SV *
wrap_gmp_printf (a, b)
	SV *	a
	SV *	b
CODE:
  RETVAL = wrap_gmp_printf (aTHX_ a, b);
OUTPUT:  RETVAL

SV *
wrap_gmp_fprintf (stream, a, b)
	FILE *	stream
	SV *	a
	SV *	b
CODE:
  RETVAL = wrap_gmp_fprintf (aTHX_ stream, a, b);
OUTPUT:  RETVAL

SV *
wrap_gmp_sprintf (s, a, b, buflen)
	SV *	s
	SV *	a
	SV *	b
	int	buflen
CODE:
  RETVAL = wrap_gmp_sprintf (aTHX_ s, a, b, buflen);
OUTPUT:  RETVAL

SV *
wrap_gmp_snprintf (s, bytes, a, b, buflen)
	SV *	s
	SV *	bytes
	SV *	a
	SV *	b
	int	buflen
CODE:
  RETVAL = wrap_gmp_snprintf (aTHX_ s, bytes, a, b, buflen);
OUTPUT:  RETVAL

int
_itsa (a)
	SV *	a
CODE:
  RETVAL = _itsa (aTHX_ a);
OUTPUT:  RETVAL

int
_has_longlong ()


int
_has_longdouble ()


int
_has_inttypes ()


SV *
___GNU_MP_VERSION ()
CODE:
  RETVAL = ___GNU_MP_VERSION (aTHX);
OUTPUT:  RETVAL


SV *
___GNU_MP_VERSION_MINOR ()
CODE:
  RETVAL = ___GNU_MP_VERSION_MINOR (aTHX);
OUTPUT:  RETVAL


SV *
___GNU_MP_VERSION_PATCHLEVEL ()
CODE:
  RETVAL = ___GNU_MP_VERSION_PATCHLEVEL (aTHX);
OUTPUT:  RETVAL


SV *
___GNU_MP_RELEASE ()
CODE:
  RETVAL = ___GNU_MP_RELEASE (aTHX);
OUTPUT:  RETVAL


SV *
___GMP_CC ()
CODE:
  RETVAL = ___GMP_CC (aTHX);
OUTPUT:  RETVAL


SV *
___GMP_CFLAGS ()
CODE:
  RETVAL = ___GMP_CFLAGS (aTHX);
OUTPUT:  RETVAL


SV *
overload_inc (p, second, third)
	SV *	p
	SV *	second
	SV *	third
CODE:
  RETVAL = overload_inc (aTHX_ p, second, third);
OUTPUT:  RETVAL

SV *
overload_dec (p, second, third)
	SV *	p
	SV *	second
	SV *	third
CODE:
  RETVAL = overload_dec (aTHX_ p, second, third);
OUTPUT:  RETVAL

SV *
_wrap_count ()
CODE:
  RETVAL = _wrap_count (aTHX);
OUTPUT:  RETVAL


SV *
_get_xs_version ()
CODE:
  RETVAL = _get_xs_version (aTHX);
OUTPUT:  RETVAL


SV *
_GMP_LIMB_BITS ()
CODE:
  RETVAL = _GMP_LIMB_BITS (aTHX);
OUTPUT:  RETVAL


SV *
_GMP_NAIL_BITS ()
CODE:
  RETVAL = _GMP_NAIL_BITS (aTHX);
OUTPUT:  RETVAL


