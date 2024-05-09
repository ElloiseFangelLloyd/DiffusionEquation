#--------------
# to run this code: 
# make new 
# ./diffusion
#----------------------------------------------------------------------                                           
#  Makefile : diffusion                                                            
#  Authors   : Elloïse Fangel-Lloyd, Dana Lüdemann, Clemens Zengler                                                                                                                     
#----------------------------------------------------------------------
SHELL       = /bin/sh
TARGET      = diffusion
#----------------------------------------------------------------------
#  Compiler settings (Linux)
#----------------------------------------------------------------------
F77         = f90
CC          = cc
DEBUG       = -C
DEBUG       = 
OPT         = -O3
FFLAGS      = $(OPT) -free $(DEBUG)
CFLAGS      = -O
LD          = $(F77)
LDFLAGS     = 
CPP         = /lib/cpp
DEFINE      = 
LIBS        = 

#----------------------------------------------------------------------
#  Search path for RCS files                                           
#----------------------------------------------------------------------
VPATH = ./RCS

#----------------------------------------------------------------------
#  Additional suffix rules                                             
#----------------------------------------------------------------------
.SUFFIXES : .inc .inc,v .f,v .c,v
.f,v.f :
	 co $*.f

.c,v.c :
	 co $*.c

.inc,v.inc :
	 co $*.inc

#----------------------------------------------------------------------
#  Binary directory
#----------------------------------------------------------------------
bindir      = $(HOME)/bin

#----------------------------------------------------------------------
#  Default target

#----------------------------------------------------------------------
all: $(TARGET)

#----------------------------------------------------------------------
#  Object files:                                                       
#  NOTE: you HAVE to sort the objects files such that no file will 
#  depend on files below it ! in this example, the diffuse2.f and .o
#  depends on all he module files (i named them m_*.f), and the m_init
#  depends (USE) the m_diffuse; thus m_diffuse HAS to be compiled 
#  before m_init and before diffuse2
#----------------------------------------------------------------------
OBJS =\
	module_precise.o\
	module_timings.o\
	module_diag.o\
	module_inputs.o\
	module_diffuse.o\
	module_setup.o\
	module_output.o\
	diffusion.o

#----------------------------------------------------------------------
#  Dependencies:                                                       
#  NOTE: add the dependencies here explicitly ! 
#  In that way you are sure diffuse2.f will be recompile if any of the
#  modules source files are modified.
#----------------------------------------------------------------------
diffusion.o: diffusion.f90 module_diffuse.f90 module_setup.f90 module_inputs.f90 module_output.f90 
	$(F77) $(FFLAGS)  -c diffusion.f90
module_diffuse.o: module_diffuse.f90 module_precise.f90
	$(F77) $(FFLAGS)  -c module_diffuse.f90
module_setup.o: module_setup.f90 module_precise.f90
	$(F77) $(FFLAGS)  -c module_setup.f90
module_output.o: module_output.f90 module_precise.f90
	$(F77) $(FFLAGS)  -c module_output.f90
module_inputs.o: module_inputs.f90
	$(F77) $(FFLAGS)  -c module_inputs.f90
module_precise.o: module_precise.f90
	$(F77) $(FFLAGS)  -c module_precise.f90
module_timings.o: module_timings.f90
	$(F77) $(FFLAGS)  -c module_timings.f90
module_diag.o: module_diag.f90
	$(F77) $(FFLAGS)  -c module_diag.f90

#----------------------------------------------------------------------
#  link                                                                
#----------------------------------------------------------------------
$(TARGET): $(OBJS)
	$(LD) -o $(TARGET) $(LDFLAGS) $(OBJS) $(LIBS)

#----------------------------------------------------------------------
#  Install                                                             
#----------------------------------------------------------------------
install: $(TARGET)
	(cp -f $(TARGET) $(bindir))

#----------------------------------------------------------------------
#  Run                                                                 
#----------------------------------------------------------------------
run: $(TARGET)
	$(TARGET)

#----------------------------------------------------------------------
#  Clean                                                               
#----------------------------------------------------------------------
new: cleanall diffusion
cleanall:
	 rm -f __*.f
	 rm -f $(OBJS)
	 rm -f *.lst
	 rm -f *.mod
	 rm -f *.l
	 rm -f *.L

clean:
	 rm -f __*.f
	 rm -f *.lst
