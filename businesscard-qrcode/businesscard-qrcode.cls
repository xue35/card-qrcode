\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{businesscard-qrcode}[2018/08/10 businesscard or visitingcard with full vcard-file in qr-code]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
	family=BCQ,
	prefix=BCQ@
}
\DeclareStringOption[89mm]{paperwidth}
\DeclareStringOption[59mm]{paperheight}
\DeclareStringOption[85mm]{contentwidth}
\DeclareStringOption[55mm]{contentheight}
\DeclareStringOption[8pt]{fontsize}
\DeclareStringOption[2mm]{padding}
\DeclareStringOption[2]{cutdist}
\DeclareStringOption[1]{cutlen}
\DeclareStringOption[0.55]{textwidth}
\DeclareStringOption[0.40]{qrwidth}
\DeclareStringOption[de]{lang}
\DeclareBoolOption[true]{hint}
\DeclareComplementaryOption{nohint}{hint}

\DeclareDefaultOption{\@unknownoptionerror}

\ProcessKeyvalOptions*
\ProcessOptions\relax

\LoadClass[\BCQ@fontsize]{extarticle}

\def\content{paperwidth=\BCQ@contentwidth,paperheight=\BCQ@contentheight}
\def\papersize{width=\BCQ@paperwidth,height=\BCQ@paperheight}
\def\padding{\BCQ@padding} % padding around the content
\def\border{\BCQ@cutdist} % distance between start of cutmark and content in mm
\def\cutlen{\BCQ@cutlen} % length of ct marks in mm
\def\textpercents{\BCQ@textwidth} % size of text part 0..1
\def\imagepercents{\BCQ@qrwidth} % size of qrcode image part 0..1
\def\lang{\BCQ@lang}

\newcommand\exec[1]{\csname #1\endcsname}
\newcommand\insa[3][]{\ifcsdef{#2}{\ \\\exec{#3}\ifBCQ@hint{\tiny#1}\fi\hfill\exec{#2}}{}}
\newcommand\ifexists[2]{\ifcsdef{#1}{#2}{}}

\newcommand\name{\ifexists{tit}{\tit\ }\firstname\ \lastname}

\newcommand\vcard{BEGIN:VCARD^^J
VERSION:4.0^^J
N:\lastname;\firstname;;\ifexists{tit}{\tit};^^J
FN:\name^^J
\ifexists{printaddress}{ADR\ifexists{type}{;TYPE=\type}:;;\street;\city;;\zip;\country^^J}
\ifexists{phone}{TEL;VALUE=uri;TYPE=\ifexists{type}{\type,}voice,text:tel:\phone^^J}
\ifexists{email}{EMAIL\ifexists{type}{;TYPE=\type}:\email^^J}
\ifexists{jabber}{IMPP;TYPE=XMPP:\jabber^^J}
\ifexists{matrixorg}{IMPP;TYPE=MATRIX:\matrixorg^^J}
\ifexists{cloud}{URL:https://nextcloud.com/federation/\#\cloud^^J}
\ifexists{homepage}{URL:https://\homepage^^J}
\ifexists{wordpress}{URL:https://\wordpress^^J}
\ifexists{drupal}{URL:https://\drupal^^J}
\ifexists{joomla}{URL:https://\joomla^^J}
\ifexists{wikipedia}{URL:https://\lang.wikipedia.org/wiki/\wikipedia^^J}
\ifexists{link}{URL:https://\link^^J}
\ifexists{world}{URL:https://\world^^J}
\ifexists{git}{URL:https://\git^^J}
\ifexists{gitea}{URL:https://\gitea^^J}
\ifexists{github}{URL:https://github.com/\github^^J}
\ifexists{facebook}{URL:https://www.facebook.com/\facebook^^J}
\ifexists{twitter}{URL:https://twitter.com/\twitter^^J}
\ifexists{youtube}{URL:https://www.youtube.com/user/\youtube^^J}
\ifexists{google}{URL:https://plus.google.com/+\google^^J}
\ifexists{pgpurl}{KEY;MEDIATYPE=application/pgp-keys:\pgpurl^^J}
\ifexists{pgpfingerprint}{KEY:data:application/x-pgp-fingerprint,\pgpfingerprint^^J}
END:VCARD^^J}

\RequirePackage{marvosym}
\RequirePackage{fontawesome}

\newcommand\address{
	\ifexists{printaddress}{
		\ \\
		\faMapMarker\hfill\street \\
		\zip\ \city \\
		\country \\
	}
	\insa[tel:]{phone}{faMobile}\insa[mailto:]{email}{Email}\insa[xmpp]{jabber}{faCommentsO}\insa[matrix.org]{matrixorg}{faCommentsO}\insa[nextcloud-id]{cloud}{faCloud}\insa[https://]{homepage}{faHome}\insa[https://]{wordpress}{faWordpress}\insa[https://]{drupal}{faDrupal}\insa[https://]{joomla}{faJoomla}\insa[https://\lang.wikipedia.org/wiki/]{wikipedia}{faWikipediaW}\insa[https://]{link}{faLink}\insa[https://]{world}{faGlobe}\insa[https://]{git}{faGit}\insa[https://]{gitea}{faGithubAlt}\insa[https://github.com/]{github}{faGithub}\insa[https://facebook.com/]{facebook}{faFacebook}\insa[https://twitter.com/]{twitter}{faTwitter}\insa[https://youtube.com/user/]{youtube}{faYoutube}\insa[https://plus.google.com/+]{google}{faGooglePlus}
}

\pagestyle{empty}
\setlength{\parindent}{0pt}

\RequirePackage[final]{qrcode}
\RequirePackage{etoolbox}

\RequirePackage{DejaVuSans}
\renewcommand*\familydefault{\sfdefault}
\RequirePackage[T1]{fontenc}

\RequirePackage{wrapfig}

\RequirePackage[\content,top=\padding,left=\padding,right=\padding,bottom=\padding]{geometry}

\RequirePackage[\papersize,noinfo,center,pdftex]{crop}
\newcommand\tl{
	\begin{picture}(0,0)
		\thinlines\unitlength1mm
		\put(-\border,0){\line(1,0){\cutlen}}
		\put(0,\border){\line(0,-1){\cutlen}}
	\end{picture}
}
\newcommand\tr{
	\begin{picture}(0,0)
	\thinlines\unitlength1mm
	\put(\border,0){\line(-1,0){\cutlen}}
	\put(0,\border){\line(0,-1){\cutlen}}
	\end{picture}
}
\newcommand\bl{
	\begin{picture}(0,0)
	\thinlines\unitlength1mm
	\put(-\border,0){\line(1,0){\cutlen}}
	\put(0,-\border){\line(0,1){\cutlen}}
	\end{picture}
}
\newcommand\br{
	\begin{picture}(0,0)
	\thinlines\unitlength1mm
	\put(\border,0){\line(-1,0){\cutlen}}
	\put(0,-\border){\line(0,1){\cutlen}}
	\end{picture}
}
\cropdef[]\tl\tr\bl\br{cut}
\crop[cut]

\newcommand\drawcard{
	\begin{minipage}[c][0.9\textheight][c]{\imagepercents\textwidth}
		\qrcode[level=Q,version=0,height=\textwidth]{\vcard}
	\end{minipage}
	\hfill
	\begin{minipage}[c][0.9\textheight][c]{\textpercents\textwidth}
		\raggedleft
		{\bfseries\name} \\
		\address
	\end{minipage}
	\ifexists{pgpfingerprint}{
		
		\faLock\ifBCQ@hint{\tiny pgp}\fi\hfill{\small\pgpfingerprint}}
}
