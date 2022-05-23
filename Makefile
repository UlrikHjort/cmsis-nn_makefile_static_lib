# Makefile for building cmsis-nn static lib.
# Place in CMSIS_5/CMSIS/NN in https://github.com/ARM-software/CMSIS_5

STATIC_LIB_DIR=./lib 
STATIC_LIB_FILE_NAME = libcmsisnn.a 

CFLAGS_M7= -g -fPIC -c -mcpu=cortex-m7 -Ofast -DNDEBUG  -mfpu=fpv5-sp-d16 -mfloat-abi=hard -mthumb
CFLAGS_M4= -fPIC -c -mcpu=cortex-m4 -Ofast -DNDEBUG  -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb
CFLAGS=$(CFLAGS_M7)
INC = -I../Core/Include -I../DSP/PrivateInclude -I../DSP/Include -I../NN/Include  
rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d)) 
SOURCE_FILES = $(call rwildcard,Source,*.c) 
OBJECT_FILES = $(patsubst %.c,%.o,$(wildcard $(SOURCE_FILES))) 


$(STATIC_LIB_FILE_NAME): $(OBJECT_FILES) 
	ar -r -o ./lib/$@ $^ 

%.o: %.c dirmake 
	arm-none-eabi-gcc -c $(INC) $(CFLAGS) -o $@  $< 
dirmake: 
	@mkdir -p $(STATIC_LIB_DIR) 
clean: 
	rm -f $(OBJECT_FILES) $(STATIC_LIB_DIR)/$(STATIC_LIB_FILE_NAME) 




