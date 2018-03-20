
CXX             = g++

INCDIR          = ./include/
SRCDIR          = ./src/
BINDIR          = ./bin/

OK              = \033[30;32mOK\033[m
FAILED          = \033[30;31mFAILED\033[m


MODULE	= main

CFLAGS 	= -lpthread

SOURCES = \
	Thread.cpp\
	TestThread.cpp\
    main.cpp


.SUFFIXES: .cpp .o .h



OBJS   = $(SOURCES:.cpp=.o)

EXE    = $(BINDIR)$(MODULE)


all: $(EXE)

$(EXE): $(addprefix $(SRCDIR),$(OBJS))
	@echo ===============================================================================
	@mkdir $(BINDIR) > /dev/null 2>&1 && \
		echo "Criando diretorio $(BINDIR) ... $(OK)" || echo -n ""
	@echo -n Compilando arquivo $(MODULE) estatico ...
	@$(CXX) $(addprefix $(SRCDIR),$(OBJS)) $(CFLAGS) -o $(EXE) && \
        echo " $(OK)" || (echo " $(FAILED)"; exit 1;)

%.o: %.cpp
	@echo -n  Compilando arquivo $(notdir $<) para $(notdir $@) ...
	@$(CXX) $(CFLAGS) -c $< -o $@ && \
		echo " $(OK)" || (echo " $(FAILED)"; exit 1;)


clean:
	@echo -n Limpando ...
	@rm -rf $(addprefix $(SRCDIR),$(OBJS)) $(BINDIR) src/*.o 2> /dev/null && \
                echo " $(OK)" || (echo " $(FAILED)"; exit 1;)
  


default: all

