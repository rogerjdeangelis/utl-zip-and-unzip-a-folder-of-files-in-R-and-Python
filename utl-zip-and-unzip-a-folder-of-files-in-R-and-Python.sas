%let pgm=utl-zip-and-unzip-a-folder-of-files-in-R-and-Python;

Zip and unzip all files in a zip archive in R and Python

github
https://tinyurl.com/bdfyc8b9
https://github.com/rogerjdeangelis/utl-zip-and-unzip-a-folder-of-files-in-R-and-Python

related
https://tinyurl.com/28b4wy8e
https://github.com/rogerjdeangelis?tab=repositories&q=zip&type=&language=&sort=

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

/*---- we need three folders                 ----*/

d:/txt    /*----    for input files          ----*/
d:/zip    /*----    for zip files            ----*/
d:/unzip  /*----    for unziped files        ----*/

/*----  ceate input directory and with files ----*/
data _null_;

  * create directory;
  if _n_=0 then do;
      %let rc=%sysfunc(dosubl('
         data _null_;
             rc=dcreate("txt","d:/");
             rc=dcreate("zip","d:/");
             rc=dcreate("unzip","d:/");
         run;quit;
     '));
  end;

  file "d:/txt/file1.txt"; put "file1";
  file "d:/txt/file2.txt"; put "file2";
  file "d:/txt/file3.txt"; put "file3";

run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* x 'tree "d:/txt" /F /A | clip';                                                                                        */
/*                                                                                                                        */
/*  D:\TXT                                                                                                                */
/*                                                                                                                        */
/*      file1.txt                                                                                                         */
/*      file2.txt                                                                                                         */
/*      file3.txt                                                                                                         */
/*                                                                                                                        */
/*  D:\ZIP                                                                                                                */
/*                                                                                                                        */
/*  D:\UNZIP                                                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*          _
 _ __   ___(_)_ __
| `__| |_  / | `_ \
| |     / /| | |_) |
|_|    /___|_| .__/
             |_|
*/

%utl_submit_r64('
  library(zip);
  library(SASxport);
  dir<-"d:/txt";
  zipr("d:/zip/txt.zip","d:/txt");
  arclst<-zip_list("d:/zip/txt.zip");
  str(arclst);
  write.xport(arclst,file="d:/xpt/arclst.xpt");
');

libname xpt xport "d:/xpt/arclst.xpt";

proc print data=xpt.arclst;
run;quit;

/*   _                     _               _
 ___(_)_ __     ___  _   _| |_ _ __  _   _| |_
|_  / | `_ \   / _ \| | | | __| `_ \| | | | __|
 / /| | |_) | | (_) | |_| | |_| |_) | |_| | |_
/___|_| .__/   \___/ \__,_|\__| .__/ \__,_|\__|
      |_|                     |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/* x 'tree "d:/zip" /F /A | clip';                                                                                        */
/*                                                                                                                        */
/* D:\ZIP                                                                                                                 */
/*   txt.zip                                                                                                              */
/*                                                                                                                        */
/* Archive listing from R                                                                                                 */
/*                                                                                                                        */
/*                                                                                                                        */
/*  Obs    FILENAME         COMPRESS    UNCOMPRE     TIMESTAM     PERMISSI     CRC32      OFFSET                          */
/*                                                                                                                        */
/*    1    txt/                 0           0       1998123816      700       00000000        0                           */
/*    2    txt/file1.txt       12           7       1998123816      600       7a197dba       34                           */
/*    3    txt/file2.txt       12           7       1998123816      600       785fc3e3      105                           */
/*    4    txt/file3.txt       12           7       1998123816      600       799da9d4      176                           */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _   _                       _
 _ __  _   _| |_| |__   ___  _ __    ___(_)_ __
| `_ \| | | | __| `_ \ / _ \| `_ \  |_  / | `_ \
| |_) | |_| | |_| | | | (_) | | | |  / /| | |_) |
| .__/ \__, |\__|_| |_|\___/|_| |_| /___|_| .__/
|_|    |___/                              |_|
*/

%utl_submit_py64_310('
import shutil;
shutil.make_archive("d:/zip/txt_py", "zip", "d:/txt");
');

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  x 'tree "d:/zip" /F /A | clip';                                                                                       */
/*                                                                                                                        */
/*  D:\ZIP                                                                                                                */
/*    txt_py.zip                                                                                                          */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                      _
 _ __   _   _ _ __  ___(_)_ __
| `__| | | | | `_ \|_  / | `_ \
| |    | |_| | | | |/ /| | |_) |
|_|     \__,_|_| |_/___|_| .__/
                         |_|
*/

%utl_submit_r64("
  library(zip);
     unzip(
      'd:/zip/txt.zip'
      ,exdir='d:/unzip'
       );
     ");

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  x 'tree "d:/zip" /F /A | clip';                                                                                       */
/*                                                                                                                        */
/*  D:\UNZIP                                                                                                              */
/*    \TXT\file1.txt                                                                                                      */
/*    \TXT\file2.txt                                                                                                      */
/*    \TXT\file3.txt                                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _   _                                   _
 _ __  _   _| |_| |__   ___  _ __    _   _ _ __  ___(_)_ __
| `_ \| | | | __| `_ \ / _ \| `_ \  | | | | `_ \|_  / | `_ \
| |_) | |_| | |_| | | | (_) | | | | | |_| | | | |/ /| | |_) |
| .__/ \__, |\__|_| |_|\___/|_| |_|  \__,_|_| |_/___|_| .__/
|_|    |___/                                          |_|
*/

%utl_submit_py64_310('
import shutil;
shutil.unpack_archive("d:/zip/txt.zip","d:/unzip"  , "zip" );
');

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  D:\UNZIP                                                                                                              */
/*    \TXT\file1.txt                                                                                                      */
/*    \TXT\file2.txt                                                                                                      */
/*    \TXT\file3.txt                                                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
