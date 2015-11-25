# Variables for libcaca (terminal video output)
CACA_LIBS = caca
CACA_CFLAGS = -DCACA
# ifneq (, $(findstring audio_device.o, $(OBJ)))
#     CACA_OBJ = audio_call.o
# else
#     CACA_OBJ = audio_call.o audio_device.o
# endif

# Check if we can build audio support
CHECK_CACA_LIBS = $(shell $(PKG_CONFIG) --exists $(CACA_LIBS) || echo -n "error")
ifneq ($(CHECK_CACA_LIBS), error)
    LIBS += $(CACA_LIBS)
    CFLAGS += $(CACA_CFLAGS)
    # OBJ += $(CACA_OBJ)
else ifneq ($(MAKECMDGOALS), clean)
    MISSING_CACA_LIBS = $(shell for lib in $(CACA_LIBS) ; do if ! $(PKG_CONFIG) --exists $$lib ; then echo $$lib ; fi ; done)
    $(warning WARNING -- Toxic will be compiled without terminal video support)
    $(warning WARNING -- You need these libraries for terminal video support)
    $(warning WARNING -- $(MISSING_CACA_LIBS))
endif
