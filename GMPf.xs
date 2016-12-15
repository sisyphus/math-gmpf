
#ifdef  __MINGW32__
#ifndef __USE_MINGW_ANSI_STDIO
#define __USE_MINGW_ANSI_STDIO 1
#endif
#endif

#define PERL_NO_GET_CONTEXT 1

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"


#include "math_gmpf_include.h"

int nok_pok = 0; /* flag that is incremented whenever a scalar that is both *
                  * NOK and POK is passed to new or an overloaded operator  */

int NOK_POK_val(pTHX) {
  /* return the numeric value of $Math::GMPf::NOK_POK */
  return SvIV(get_sv("Math::GMPf::NOK_POK", 0));
}

int _is_infstring(char * s) {
  int sign = 1;

  if(s[0] == '-') {
    sign = -1;
    s++;
  }
  else {
    if(s[0] == '+') s++;
  }

  if((s[0] == 'i' || s[0] == 'I') && (s[1] == 'n' || s[1] == 'N') && (s[2] == 'f' || s[2] == 'F'))
    return sign;

#ifdef _WIN32_BIZARRE_INFNAN /* older Win32 perls stringify infinities as(-)1.#INF */

   if(!strcmp(s, "1.#INF")) return sign;

#endif

  return 0;
}

int _is_nanstring(char * s) {
  int sign = 1;

  if(s[0] == '-') {
    sign = -1;
    s++;
  }
  else {
    if(s[0] == '+') s++;
  }

  if((s[0] == 'n' || s[0] == 'N') && (s[1] == 'a' || s[1] == 'A') && (s[2] == 'n' || s[2] == 'N'))
    return sign;

#ifdef _WIN32_BIZARRE_INFNAN /* older Win32 perls stringify infinities as(-)1.#INF */

   if(!strcmp(s, "1.#IND")) return sign;

#endif

  return 0;
}

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

     if(a != a)
       croak("In Rmpf_init_set_d, cannot coerce a NaN to a Math::GMPf object");
     if(a != 0 && (a / a != 1))
       croak("In Rmpf_init_set_d, cannot coerce an Inf to a Math::GMPf object");

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
#if defined(NV_IS_LONG_DOUBLE) || defined(NV_IS_FLOAT128)
     char * buffer;
     int exp, exp2 = 0;
     long double fr, buffer_size;

     fr = (long double)SvNV(p);

     if(fr != fr)
       croak("In _Rmpf_set_ld, cannot coerce a NaN to a Math::GMPf object");
     if(fr != 0.0L && (fr / fr != 1))
       croak("In _Rmpf_set_ld, cannot coerce an Inf to a Math::GMPf object");

     fr = frexpl(fr, &exp);

     while(fr != floorl(fr)) {
          fr *= 2;
          exp2 += 1;
     }

     buffer_size = fr < 0.0L ? fr * -1.0L : fr;
     buffer_size = ceill(logl(buffer_size + 1) / 2.30258509299404568401799145468436418L);

     Newxz(buffer, (int)buffer_size + 5, char);

     sprintf(buffer, "%.0Lf", fr);

     mpf_set_str(*q, buffer, 10);

     Safefree(buffer);

     if (exp2 > exp) mpf_div_2exp(*q, *q, exp2 - exp);
     else mpf_mul_2exp(*q, *q, exp - exp2);
#else
     croak("_Rmpf_set_ld not implemented on this build of perl");
#endif
}

void _Rmpf_set_float128(pTHX_ mpf_t *q, SV * p) {

#if defined(NV_IS_FLOAT128)

     char * buffer;
     int exp, exp2 = 0, returned;
     float128 fr, buffer_size;

     fr = (float128)SvNV(p);

     if(fr != fr)
       croak("In _Rmpf_set_float128, cannot coerce a NaN to a Math::GMPf object");
     if(fr != 0.0Q && (fr / fr != 1))
       croak("In _Rmpf_set_float128, cannot coerce an Inf to a Math::GMPf object");

     fr = frexpq(fr, &exp);

     while(fr != floorq(fr)) {
          fr *= 2;
          exp2 += 1;
     }

     buffer_size = fr < 0.0Q ? fr * -1.0Q : fr;
     buffer_size = ceilq(logq(buffer_size + 1) / 2.30258509299404568401799145468436418Q);

     Newxz(buffer, (int)buffer_size + 5, char);

     returned = quadmath_snprintf(buffer, (size_t)buffer_size + 5, "%.0Qf", fr);
     if(returned < 0) croak("In _Rmpf_set_float128, encoding error in quadmath_snprintf function");
     if(returned >= buffer_size + 5) croak("In _Rmpf_set_float128, buffer given to quadmath_snprintf function was too small");

     mpf_set_str(*q, buffer, 10);

     Safefree(buffer);

     if (exp2 > exp) mpf_div_2exp(*q, *q, exp2 - exp);
     else mpf_mul_2exp(*q, *q, exp - exp2);

#else

     croak("_Rmpf_set_float128 not implemented on this build of perl");

#endif

}

void Rmpf_set_d(mpf_t * p, double d) {

     if(d != d)
       croak("In Rmpf_set_d, cannot coerce a NaN to a Math::GMPf object");
     if(d != 0 && (d / d != 1))
       croak("In Rmpf_set_d, cannot coerce an Inf to a Math::GMPf object");

     mpf_set_d(*p, d);
}

void Rmpf_set_NV(pTHX_ mpf_t *q, SV * p) {

#if defined(NV_IS_FLOAT128)

     _Rmpf_set_float128(aTHX_ q, p);

#elif defined(NV_IS_LONG_DOUBLE)

     _Rmpf_set_ld(aTHX_ q, p);

#else

     Rmpf_set_d(q, SvNV(p));

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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_mul", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_mul");}

       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string (%s) supplied to Math::GMPf::overload_mul", SvPV_nolen(b));
       mpf_mul(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(SvNOK(b)) {
#ifdef NV_IS_LONG_DOUBLE
       _Rmpf_set_ld(aTHX_ mpf_t_obj, b);
#else
       Rmpf_set_d(mpf_t_obj, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_add", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_add");}

       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string (%s) supplied to Math::GMPf::overload_add", SvPV_nolen(b));
       mpf_add(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(SvNOK(b)) {
#ifdef NV_IS_LONG_DOUBLE
       _Rmpf_set_ld(aTHX_ mpf_t_obj, b);
#else
       Rmpf_set_d(mpf_t_obj, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_sub", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_sub");}

       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string (%s) supplied to Math::GMPf::overload_sub", SvPV_nolen(b));
       if(third == &PL_sv_yes) mpf_sub(*mpf_t_obj, *mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_sub(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(SvNOK(b)) {
#ifdef NV_IS_LONG_DOUBLE
       _Rmpf_set_ld(aTHX_ mpf_t_obj, b);
#else
       Rmpf_set_d(mpf_t_obj, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_div", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_div");}

       if(mpf_set_str(*mpf_t_obj, SvPV_nolen(b), 10))
         croak("Invalid string (%s) supplied to Math::GMPf::overload_div", SvPV_nolen(b));
       if(third == &PL_sv_yes) mpf_div(*mpf_t_obj, *mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))));
       else mpf_div(*mpf_t_obj, *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *mpf_t_obj);
       return obj_ref;
     }

     if(SvNOK(b)) {
#ifdef NV_IS_LONG_DOUBLE
       _Rmpf_set_ld(aTHX_ mpf_t_obj, b);
#else
       Rmpf_set_d(mpf_t_obj, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_gt", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_gt");}

       if(_is_nanstring(SvPV_nolen(b))) return newSViv(0);
       ret = _is_infstring(SvPV_nolen(b));
       if(ret) ret *= -1;
       else {
         if(mpf_init_set_str(t, SvPV_nolen(b), 10))
           croak("Invalid string (%s) supplied to Math::GMPf::overload_gt", SvPV_nolen(b));
         ret = mpf_cmp(*a, t);
         mpf_clear(t);
       }
       if(third == &PL_sv_yes) ret *= -1;
       if(ret > 0) return newSViv(1);
       return newSViv(0);
     }

     if(SvNOK(b)) {

       if(SvNVX(b) != SvNVX(b)) return newSVnv(0);
       if(SvNVX(b) != 0 && (SvNVX(b) / SvNVX(b) != 1)) {
         if(SvNVX(b) > 0) ret = -1;
         else ret = 1;
         if(third == &PL_sv_yes) ret *= -1;
         if(ret > 0) return newSViv(1);
         return newSViv(0);
       }

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ &t, b);

#elif defined(NV_IS_LONG_DOUBLE)

       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       mpf_set_d(t, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_gte", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_gte");}

       if(_is_nanstring(SvPV_nolen(b))) return newSViv(0);
       ret = _is_infstring(SvPV_nolen(b));
       if(ret) ret *= -1;
       else {
         if(mpf_init_set_str(t, SvPV_nolen(b), 10))
           croak("Invalid string (%s) supplied to Math::GMPf::overload_gte", SvPV_nolen(b));
         ret = mpf_cmp(*a, t);
         mpf_clear(t);
       }
       if(third == &PL_sv_yes) ret *= -1;
       if(ret >= 0) return newSViv(1);
       return newSViv(0);
     }

     if(SvNOK(b)) {

       if(SvNVX(b) != SvNVX(b)) return newSVnv(0);
       if(SvNVX(b) != 0 && (SvNVX(b) / SvNVX(b) != 1)) {
         if(SvNVX(b) > 0) ret = -1;
         else ret = 1;
         if(third == &PL_sv_yes) ret *= -1;
         if(ret > 0) return newSViv(1);
         return newSViv(0);
       }

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ &t, b);

#elif defined(NV_IS_LONG_DOUBLE)

       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       mpf_set_d(t, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_lt", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_lt");}

       if(_is_nanstring(SvPV_nolen(b))) return newSViv(0);
       ret = _is_infstring(SvPV_nolen(b));
       if(ret) ret *= -1;
       else {
         if(mpf_init_set_str(t, SvPV_nolen(b), 10))
           croak("Invalid string (%s) supplied to Math::GMPf::overload_lt", SvPV_nolen(b));
         ret = mpf_cmp(*a, t);
         mpf_clear(t);
       }
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(1);
       return newSViv(0);
     }

     if(SvNOK(b)) {

       if(SvNVX(b) != SvNVX(b)) return newSVnv(0);
       if(SvNVX(b) != 0 && (SvNVX(b) / SvNVX(b) != 1)) {
         if(SvNVX(b) > 0) ret = 1;
         else ret = -1;
         if(third == &PL_sv_yes) ret *= -1;
         if(ret > 0) return newSViv(1);
         return newSViv(0);
       }

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ &t, b);

#elif defined(NV_IS_LONG_DOUBLE)
       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       mpf_set_d(t, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_lte", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_lte");}

       if(_is_nanstring(SvPV_nolen(b))) return newSViv(0);
       ret = _is_infstring(SvPV_nolen(b));
       if(ret) ret *= -1;
       else {
         if(mpf_init_set_str(t, SvPV_nolen(b), 10))
           croak("Invalid string (%s) supplied to Math::GMPf::overload_lte", SvPV_nolen(b));
         ret = mpf_cmp(*a, t);
         mpf_clear(t);
       }
       if(third == &PL_sv_yes) ret *= -1;
       if(ret <= 0) return newSViv(1);
       return newSViv(0);
     }

     if(SvNOK(b)) {
       if(SvNVX(b) != SvNVX(b)) return newSVnv(0);
       if(SvNVX(b) != 0 && (SvNVX(b) / SvNVX(b) != 1)) {
         if(SvNVX(b) > 0) ret = 1;
         else ret = -1;
         if(third == &PL_sv_yes) ret *= -1;
         if(ret > 0) return newSViv(1);
         return newSViv(0);
       }

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ &t, b);

#elif defined(NV_IS_LONG_DOUBLE)
       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       mpf_set_d(t, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_spaceship", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_spaceship");}

       if(_is_nanstring(SvPV_nolen(b))) return &PL_sv_undef;
       ret = _is_infstring(SvPV_nolen(b));
       if(ret) ret *= -1;
       else {
         if(mpf_init_set_str(t, SvPV_nolen(b), 10))
           croak("Invalid string (%s) supplied to Math::GMPf::overload_spaceship", SvPV_nolen(b));
         ret = mpf_cmp(*a, t);
         mpf_clear(t);
       }
       if(third == &PL_sv_yes) ret *= -1;
       if(ret < 0) return newSViv(-1);
       if(ret > 0) return newSViv(1);
       return newSViv(0);
     }

     if(SvNOK(b)) {

       if(SvNVX(b) != SvNVX(b)) return &PL_sv_undef;;
       if(SvNVX(b) != 0 && (SvNVX(b) / SvNVX(b) != 1)) {
         if(SvNVX(b) > 0) ret = -1;
         else ret = 1;
         if(third == &PL_sv_yes) ret *= -1;
         return newSViv(ret);
       }

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ &t, b);

#elif defined(NV_IS_LONG_DOUBLE)

       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);

#else

       mpf_init2(t, 53);
       mpf_set_d(t, SvNVX(b));

#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_equiv", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_equiv");}

       if(_is_nanstring(SvPV_nolen(b))) return newSViv(0);
       ret = _is_infstring(SvPV_nolen(b));
       if(ret) return newSViv(0); /* A Math::GMPf object cannot == an infinity */
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string (%s) supplied to Math::GMPf::overload_equiv", SvPV_nolen(b));
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(ret == 0) return newSViv(1);
       return newSViv(0);
     }

     if(SvNOK(b)) {

       if(SvNVX(b) != SvNVX(b) || (SvNVX(b) != 0 && (SvNVX(b) / SvNVX(b) != 1))) return newSViv(0);

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ &t, b);

#elif defined(NV_IS_LONG_DOUBLE)
       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       Rmpf_set_d(&t, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_not_equiv", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_not_equiv");}

       if(_is_nanstring(SvPV_nolen(b))) return newSViv(1);
       ret = _is_infstring(SvPV_nolen(b));
       if(ret) return newSVnv(1); /* A Math::GMPf object cannot == an infinity */
       if(mpf_init_set_str(t, SvPV_nolen(b), 10))
         croak("Invalid string (%s) supplied to Math::GMPf::overload_not_equiv", SvPV_nolen(b));
       ret = mpf_cmp(*a, t);
       mpf_clear(t);
       if(third == &PL_sv_yes) ret *= -1;
       if(ret != 0) return newSViv(1);
       return newSViv(0);
     }

     if(SvNOK(b)) {

       if(SvNVX(b) != SvNVX(b) || (SvNVX(b) != 0 && (SvNVX(b) / SvNVX(b) != 1))) return newSViv(1);

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ %d, b);

#elif defined(NV_IS_LONG_DOUBLE)
       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       Rmpf_set_d(&t, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_mul_eq", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_mul_eq");}

       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string (%s) supplied to Math::GMPf::overload_mul_eq", SvPV_nolen(b));
       }
       mpf_mul(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
     }

     if(SvNOK(b)) {

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ %d, b);

#elif defined(NV_IS_LONG_DOUBLE)
       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       Rmpf_set_d(&t, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_add_eq", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_add_eq");}

       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string (%s) supplied to Math::GMPf::overload_add_eq", SvPV_nolen(b));
       }
       mpf_add(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
     }

     if(SvNOK(b)) {

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ %d, b);

#elif defined(NV_IS_LONG_DOUBLE)
       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       Rmpf_set_d(&t, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_sub_eq", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_sub_eq");}

       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string (%s) supplied to Math::GMPf::overload_sub_eq", SvPV_nolen(b));
       }
       mpf_sub(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
     }

     if(SvNOK(b)) {

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ %d, b);

#elif defined(NV_IS_LONG_DOUBLE)
       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       Rmpf_set_d(&t, SvNVX(b));
#endif
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
         croak("Invalid string (%s) supplied to Math::GMPf::overload_div_eq", SvPV_nolen(b));
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

     if(SvPOK(b)) {

       NOK_POK_DUALVAR_CHECK , "overload_div_eq");}

       if(mpf_init_set_str(t, SvPV_nolen(b), 10)) {
         SvREFCNT_dec(a);
         croak("Invalid string (%s) supplied to Math::GMPf::overload_div_eq", SvPV_nolen(b));
       }
       mpf_div(*(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), *(INT2PTR(mpf_t *, SvIVX(SvRV(a)))), t);
       mpf_clear(t);
       return a;
     }

     if(SvNOK(b)) {

#if defined(NV_IS_FLOAT128)

       mpf_init2(t, 113);
       _Rmpf_set_float128(aTHX_ %d, b);

#elif defined(NV_IS_LONG_DOUBLE)
       mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
       _Rmpf_set_ld(aTHX_ &t, b);
#else
       mpf_init2(t, 53);
       Rmpf_set_d(&t, SvNVX(b));
#endif
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
     if(SvPOK(b)) {
       ret = gmp_printf(SvPV_nolen(a), SvPV_nolen(b));
       fflush(stdout);
       return newSViv(ret);
     }
     if(SvNOK(b)) {
       ret = gmp_printf(SvPV_nolen(a), SvNVX(b));
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
     if(SvPOK(b)) {
       ret = gmp_fprintf(stream, SvPV_nolen(a), SvPV_nolen(b));
       fflush(stream);
       return newSViv(ret);
     }
     if(SvNOK(b)) {
       ret = gmp_fprintf(stream, SvPV_nolen(a), SvNVX(b));
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

     if(SvPOK(b)) {
       ret = gmp_sprintf(stream, SvPV_nolen(a), SvPV_nolen(b));
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

     if(SvPOK(b)) {
       ret = gmp_snprintf(stream, (size_t)SvUV(bytes), SvPV_nolen(a), SvPV_nolen(b));
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

     croak("Unrecognised type supplied as argument to Rmpf_snprintf");
}

int _itsa(pTHX_ SV * a) {
     if(SvUOK(a)) return 1;
     if(SvIOK(a)) return 2;
     if(SvPOK(a)) return 4;
     if(SvNOK(a)) return 3;
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
#if defined(NV_IS_LONG_DOUBLE) || defined(NV_IS_FLOAT128)
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

int _nv_is_float128(void) {
#if defined(NV_IS_FLOAT128)
    return 1;
#else
    return 0;
#endif
}

int _SvNOK(pTHX_ SV * in) {
  if(SvNOK(in)) return 1;
  return 0;
}

int _SvPOK(pTHX_ SV * in) {
  if(SvPOK(in)) return 1;
  return 0;
}

int nok_pokflag(void) {
  return nok_pok;
}

void clear_nok_pok(void){
  nok_pok = 0;
}

void set_nok_pok(int x) {
  nok_pok = x;
}

SV * _Rmpf_get_float128(mpf_t * x) {

#if defined(NV_IS_FLOAT128)
     mpf_t t;
     long i, exp, retract = 0;
     char *out;
     float128 ret = 0.0Q, sign = 1.0Q;
     float128 add_on[113] = {
      5192296858534827628530496329220096e0Q, 2596148429267413814265248164610048e0Q,
      1298074214633706907132624082305024e0Q, 649037107316853453566312041152512e0Q,
      324518553658426726783156020576256e0Q, 162259276829213363391578010288128e0Q,
      81129638414606681695789005144064e0Q, 40564819207303340847894502572032e0Q,
      20282409603651670423947251286016e0Q, 10141204801825835211973625643008e0Q,
      5070602400912917605986812821504e0Q, 2535301200456458802993406410752e0Q,
      1267650600228229401496703205376e0Q, 633825300114114700748351602688e0Q,
      316912650057057350374175801344e0Q, 158456325028528675187087900672e0Q, 79228162514264337593543950336e0Q,
      39614081257132168796771975168e0Q, 19807040628566084398385987584e0Q, 9903520314283042199192993792e0Q,
      4951760157141521099596496896e0Q, 2475880078570760549798248448e0Q, 1237940039285380274899124224e0Q,
      618970019642690137449562112e0Q, 309485009821345068724781056e0Q, 154742504910672534362390528e0Q,
      77371252455336267181195264e0Q, 38685626227668133590597632e0Q, 19342813113834066795298816e0Q,
      9671406556917033397649408e0Q, 4835703278458516698824704e0Q, 2417851639229258349412352e0Q,
      1208925819614629174706176e0Q, 604462909807314587353088e0Q, 302231454903657293676544e0Q,
      151115727451828646838272e0Q, 75557863725914323419136e0Q, 37778931862957161709568e0Q,
      18889465931478580854784e0Q, 9444732965739290427392e0Q, 4722366482869645213696e0Q,
      2361183241434822606848e0Q, 1180591620717411303424e0Q, 590295810358705651712e0Q, 295147905179352825856e0Q,
      147573952589676412928e0Q, 73786976294838206464e0Q, 36893488147419103232e0Q, 18446744073709551616e0Q,
      9223372036854775808e0Q, 4611686018427387904e0Q, 2305843009213693952e0Q, 1152921504606846976e0Q,
      576460752303423488e0Q, 288230376151711744e0Q, 144115188075855872e0Q, 72057594037927936e0Q,
      36028797018963968e0Q, 18014398509481984e0Q, 9007199254740992e0Q, 4503599627370496e0Q,
      2251799813685248e0Q, 1125899906842624e0Q, 562949953421312e0Q, 281474976710656e0Q, 140737488355328e0Q,
      70368744177664e0Q, 35184372088832e0Q, 17592186044416e0Q, 8796093022208e0Q, 4398046511104e0Q,
      2199023255552e0Q, 1099511627776e0Q, 549755813888e0Q, 274877906944e0Q, 137438953472e0Q, 68719476736e0Q,
      34359738368e0Q, 17179869184e0Q, 8589934592e0Q, 4294967296e0Q, 2147483648e0Q, 1073741824e0Q, 536870912e0Q,
      268435456e0Q, 134217728e0Q, 67108864e0Q, 33554432e0Q, 16777216e0Q, 8388608e0Q, 4194304e0Q, 2097152e0Q,
      1048576e0Q, 524288e0Q, 262144e0Q, 131072e0Q, 65536e0Q, 32768e0Q, 16384e0Q, 8192e0Q, 4096e0Q, 2048e0Q,
      1024e0Q, 512e0Q, 256e0Q, 128e0Q, 64e0Q, 32e0Q, 16e0Q, 8e0Q, 4e0Q, 2e0Q, 1e0Q };

     mpf_init2(t, 113);
     mpf_set(t, *x);

     Newxz(out, 115, char);
     if(out == NULL) croak("Failed to allocate memory in _Rmpf_get_float128 function");

     mpf_get_str(out, &exp, 2, 113, t);

     mpf_clear(t);

     if(out[0] == '-') {
       sign = -1.0Q;
       out++;
       retract++;
     }
     else {
       if(out[0] == '+') {
         out++;
         retract++;
       }
     }

     for(i = 0; i < 113; i++) {
       if(out[i] == '1') ret += add_on[i];
     }

     if(retract) out--;
     Safefree(out);

     if(exp > 113) {
       retract = exp - 113; /* re-using 'retract' */
       for(i = 0; i < retract; i++) ret *= 2.0Q;
     }

     if(exp < 113) {
       for(i = exp; i < 113; i++) ret /= 2.0Q;
     }

     return newSVnv(ret * sign);

#else

     croak("_Rmpf_get_float128 not implemented for this build of Math::GMPf");

#endif

}

SV * _Rmpf_get_ld(pTHX_ mpf_t * x) {

#if defined(NV_IS_LONG_DOUBLE) || defined(NV_IS_FLOAT128)
#if REQUIRED_LDBL_MANT_DIG == 2098

     mpf_t t;
     long i, exp, retract = 0;
     char *out;
     long double ret = 0.0L, sign = 1.0L;

     mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
     mpf_set(t, *x);

     Newxz(out, 2100, char);
     if(out == NULL) croak("Failed to allocate memory in _Rmpf_get_ld function");

     mpf_get_str(out, &exp, 2, 2098, t);

     mpf_clear(t);

     if(out[0] == '-') {
       sign = -1.0L;
       out++;
       retract++;
     }
     else {
       if(out[0] == '+') {
         out++;
         retract++;
       }
     }

     for(i = 0; i < 2098; i++) {
       if(out[i] == '1') ret += powl(2.0L, (long double)out[2097 - i]);
     }

     if(retract) out--;
     Safefree(out);

     if(exp > 2098) {
       retract = exp - 2098; /* re-using 'retract' */
       for(i = 0; i < retract; i++) ret *= 2.0L;
     }

     if(exp < 2098) {
       for(i = exp; i < 2098; i++) ret /= 2.0L;
     }

     return newSVnv(ret * sign);

#else
     mpf_t t;
     long i, exp, retract = 0;
     char *out;
     long double ret = 0.0L, sign = 1.0L;
     long double add_on[113] = {
      5192296858534827628530496329220096e0L, 2596148429267413814265248164610048e0L,
      1298074214633706907132624082305024e0L, 649037107316853453566312041152512e0L,
      324518553658426726783156020576256e0L, 162259276829213363391578010288128e0L,
      81129638414606681695789005144064e0L, 40564819207303340847894502572032e0L,
      20282409603651670423947251286016e0L, 10141204801825835211973625643008e0L,
      5070602400912917605986812821504e0L, 2535301200456458802993406410752e0L,
      1267650600228229401496703205376e0L, 633825300114114700748351602688e0L,
      316912650057057350374175801344e0L, 158456325028528675187087900672e0L, 79228162514264337593543950336e0L,
      39614081257132168796771975168e0L, 19807040628566084398385987584e0L, 9903520314283042199192993792e0L,
      4951760157141521099596496896e0L, 2475880078570760549798248448e0L, 1237940039285380274899124224e0L,
      618970019642690137449562112e0L, 309485009821345068724781056e0L, 154742504910672534362390528e0L,
      77371252455336267181195264e0L, 38685626227668133590597632e0L, 19342813113834066795298816e0L,
      9671406556917033397649408e0L, 4835703278458516698824704e0L, 2417851639229258349412352e0L,
      1208925819614629174706176e0L, 604462909807314587353088e0L, 302231454903657293676544e0L,
      151115727451828646838272e0L, 75557863725914323419136e0L, 37778931862957161709568e0L,
      18889465931478580854784e0L, 9444732965739290427392e0L, 4722366482869645213696e0L,
      2361183241434822606848e0L, 1180591620717411303424e0L, 590295810358705651712e0L, 295147905179352825856e0L,
      147573952589676412928e0L, 73786976294838206464e0L, 36893488147419103232e0L, 18446744073709551616e0L,
      9223372036854775808e0L, 4611686018427387904e0L, 2305843009213693952e0L, 1152921504606846976e0L,
      576460752303423488e0L, 288230376151711744e0L, 144115188075855872e0L, 72057594037927936e0L,
      36028797018963968e0L, 18014398509481984e0L, 9007199254740992e0L, 4503599627370496e0L,
      2251799813685248e0L, 1125899906842624e0L, 562949953421312e0L, 281474976710656e0L, 140737488355328e0L,
      70368744177664e0L, 35184372088832e0L, 17592186044416e0L, 8796093022208e0L, 4398046511104e0L,
      2199023255552e0L, 1099511627776e0L, 549755813888e0L, 274877906944e0L, 137438953472e0L, 68719476736e0L,
      34359738368e0L, 17179869184e0L, 8589934592e0L, 4294967296e0L, 2147483648e0L, 1073741824e0L, 536870912e0L,
      268435456e0L, 134217728e0L, 67108864e0L, 33554432e0L, 16777216e0L, 8388608e0L, 4194304e0L, 2097152e0L,
      1048576e0L, 524288e0L, 262144e0L, 131072e0L, 65536e0L, 32768e0L, 16384e0L, 8192e0L, 4096e0L, 2048e0L,
      1024e0L, 512e0L, 256e0L, 128e0L, 64e0L, 32e0L, 16e0L, 8e0L, 4e0L, 2e0L, 1e0L };

     mpf_init2(t, REQUIRED_LDBL_MANT_DIG);
     mpf_set(t, *x);

     Newxz(out, REQUIRED_LDBL_MANT_DIG + 2, char);
     if(out == NULL) croak("Failed to allocate memory in _Rmpf_get_ld function");

     mpf_get_str(out, &exp, 2, REQUIRED_LDBL_MANT_DIG, t);

     mpf_clear(t);

     if(out[0] == '-') {
       sign = -1.0L;
       out++;
       retract++;
     }
     else {
       if(out[0] == '+') {
         out++;
         retract++;
       }
     }

     for(i = 0; i < REQUIRED_LDBL_MANT_DIG; i++) {
       if(out[i] == '1') ret += add_on[i];
     }

     if(retract) out--;
     Safefree(out);

     if(exp > 113) {
       retract = exp - 113; /* re-using 'retract' */
       for(i = 0; i < retract; i++) ret *= 2.0L;
     }

     if(exp < 113) {
       for(i = exp; i < 113; i++) ret /= 2.0L;
     }

     return newSVnv(ret * sign);

#endif
#else

     croak("_Rmpf_get_ld not implemented for this build of Math::GMPf");

#endif

}

SV * Rmpf_get_NV(pTHX_ mpf_t * x) {

#if defined(NV_IS_FLOAT128)

     return _Rmpf_get_float128(x);

#elif defined(NV_IS_LONG_DOUBLE)

     return _Rmpf_get_ld(aTHX_ x);

#else

     return newSVnv(mpf_get_d(*x));

#endif

}

int _required_ldbl_mant_dig(void) {
    return REQUIRED_LDBL_MANT_DIG;
}




MODULE = Math::GMPf  PACKAGE = Math::GMPf

PROTOTYPES: DISABLE


int
NOK_POK_val ()
CODE:
  RETVAL = NOK_POK_val (aTHX);
OUTPUT:  RETVAL


int
_is_infstring (s)
	char *	s

int
_is_nanstring (s)
	char *	s

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

void
_Rmpf_set_float128 (q, p)
	mpf_t *	q
	SV *	p
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        _Rmpf_set_float128(aTHX_ q, p);
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
Rmpf_set_NV (q, p)
	mpf_t *	q
	SV *	p
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        Rmpf_set_NV(aTHX_ q, p);
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


int
_nv_is_float128 ()


int
_SvNOK (in)
	SV *	in
CODE:
  RETVAL = _SvNOK (aTHX_ in);
OUTPUT:  RETVAL

int
_SvPOK (in)
	SV *	in
CODE:
  RETVAL = _SvPOK (aTHX_ in);
OUTPUT:  RETVAL

int
nok_pokflag ()


void
clear_nok_pok ()

        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        clear_nok_pok();
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

void
set_nok_pok (x)
	int	x
        PREINIT:
        I32* temp;
        PPCODE:
        temp = PL_markstack_ptr++;
        set_nok_pok(x);
        if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = temp;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */

SV *
_Rmpf_get_float128 (x)
	mpf_t *	x

SV *
_Rmpf_get_ld (x)
	mpf_t *	x
CODE:
  RETVAL = _Rmpf_get_ld (aTHX_ x);
OUTPUT:  RETVAL

SV *
Rmpf_get_NV (x)
	mpf_t *	x
CODE:
  RETVAL = Rmpf_get_NV (aTHX_ x);
OUTPUT:  RETVAL

int
_required_ldbl_mant_dig ()


