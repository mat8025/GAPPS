Notes regarding the contents of the CD ROM accompanying
"DSP Primer" by C. Britton Rorabaugh

All of the programs supplied on the CD were compiled using
Microsoft Visual C++ version 5.0.

The CD contains three top-level directories:

Executes - contains executable versions of each complete program
           discussed in the text or used to work an example.

recipes -  contains a 'recipe' for producing each of the programs
           provided in the 'Executes' directory.  Each recipe
           consists of a list of source files needed to build the
           executable.

DSP_Proj - contains all the information needed to modify and rebuild
           any of the programs provided in 'Executes' using
           Microsoft Visual C++ version 5.0.  Each executable was
           produced as a separate VC++ project, and there is a 
           separate sub directory for each project.  Each project's
           directory contains the '.dsp', '.dsw', and '.opt'
           files needed for MS VC++5.0.  Each directory also contains
           a make file which could possibly be modified to work with
           other C++ compilers.  The project files were built while
           the 'DSP_Proj' directory was located such that the full
           path name to 'DSP_Proj' was 
                  'C:\Program Files\DevStudio\DSP_Proj'
           If 'DSP_Proj' and all it contents are copied from the 
           CD ROM to an identically named location, the project
           files should be useable as-is.  Otherwise, the projects
           will have to be reconstituted to reflect the new locations
           of the 'sources' and 'includes' directories.
           
           In addition to the 37 project directories within 'DSP_Proj',
           there are also five support directories:

           sources -  contains C++ source code for all of the classes 
                      and functions discussed in the book or used to 
                      generate the executables (classes and functions
                      from the standard C/C++ libraries provided by 
                      compiler vendors are not included here.)

           includes - contains all of the header files needed to use 
                      the code that is provided in 'sources'

           spch_wav - contains files of speech samples in the 
                      standard '.wav' format used by Microsoft 
                      windows for sound

           spch_seq - contains files of speech samples in the
                      '.seq' format.  In this format the speech
                      samples are each represented by a single
                      integer value.  The abscissa corresponding
                      to each sample is implicit based on the 
                      sample's position within the file.

           spch_txt - contains files of speech samples in the 
                      '.txt. format.  In this format the speech
                      samples are each represented by an ordered
                      pair of integer values.  These values are
                      separated by a comma.  The first value in
                      each pair (the abscissa) is simply the 
                      running sample count beginning at the start
                      of the file.  The second value (the ordinate)
                      is an integer value identical to that used
                      in the '.seq' format.

           Note: The files in 'spch_wav', 'spch_seq', and 'spch_txt'
           are used by the programs discussed in Chap. 27 and by the 
           program 'RawFileBrowser' that is provided in the 'Executes'
           directory.  This program reads speech from '.wav' files and 
           produces either '.seq' files or '.txt' files.

