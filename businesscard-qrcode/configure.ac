#AC_PREREQ([2.69])
AC_INIT([businesscard-qrcode], [1.0], [marc@waeckerlin.org])
AM_INIT_AUTOMAKE([1.9 tar-pax])

AC_ARG_WITH([latexdir],
  [AS_HELP_STRING([--with-latexdir=DIR], [latex template files])],
  [latexdir=$withval],
  [latexdir='${datadir}/texlive/texmf-dist/tex/latex/@PACKAGE_NAME@'])
AC_SUBST([latexdir], [$latexdir])

# Checks for programs.
AC_CHECK_PROG([pandoc])
AC_CHECK_PROG([convert])
AC_CHECK_PROG([xelatex])

EXAMPLES="example john-doe-hongkong \
          peter-muster-example-company-zuerich special-papersize \
          texstudio_d30266"

AC_SUBST(EXAMPLES)

AC_CONFIG_FILES([examples/makefile
                 makefile
                 screenshots/makefile])

AC_OUTPUT
