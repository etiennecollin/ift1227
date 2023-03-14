# By Etienne Collin
# https://gist.github.com/etiennecollin/198f7520c4c58d545368a196e08f83ed
# Dependencies: ghdl, gtkwave

#### INPUT REQUIRED ####
ENTITIES = colorM1toM2_tb
VHDL_EXTENSION = vhdl
VHDL_MAIN_PATH = .
VHDL_DEPENDENCIES_PATH = .
########################

OUT_DIR = out
VHDL_MAIN := $(VHDL_MAIN_PATH)/*.$(VHDL_EXTENSION)
VHDL_DEPENDENCIES := $(VHDL_DEPENDENCIES_PATH)/*.$(VHDL_EXTENSION)
CF := $(OUT_DIR)/*.cf
GHW := $(OUT_DIR)/*.ghw
ENTITY = $(OUT_DIR)/$${entity}.ghw

VHDL_MOD_TIME = $(OUT_DIR)/vhdl_last_modification_time.txt
CF_MOD_TIME = $(OUT_DIR)/cf_last_modification_time.txt

.PHONY: all simulate clear purge

all: $(GHW)

# Make this the dependency of $(CF) if the files are always compiled even when not modified
# $(VHDL_MOD_TIME): $(VHDL_DEPENDENCIES) $(VHDL_MAIN)
# 	@$(MAKE) checkstructure
# 	@[ -f "$(VHDL_MOD_TIME)" ] || touch $(VHDL_MOD_TIME)
# 	@find $(VHDL_DEPENDENCIES) $(VHDL_MAIN) -type f -exec stat -f "%m %N" {} \; | sort -nr | head -1 > $(VHDL_MOD_TIME)

$(CF): $(VHDL_DEPENDENCIES) $(VHDL_MAIN)
	@$(MAKE) checkstructure
	@echo "Analyzing $(VHDL_EXTENSION) files..."
	@ghdl -a --workdir=$(OUT_DIR) $(VHDL_DEPENDENCIES)
	@ghdl -a --workdir=$(OUT_DIR) $(VHDL_MAIN)
	@for entity in $(ENTITIES); do \
		echo "Compiling entity $${entity}..."; \
		ghdl -e --workdir=$(OUT_DIR) $${entity}; \
	done

# Make this the dependency of $(GHW) if the files are always compiled even when not modified
# $(CF_MOD_TIME): $(CF)
# 	@[ -f "$(CF_MOD_TIME)" ] || touch $(CF_MOD_TIME)
# 	@find $(CF) -type f -exec stat -f "%m %N" {} \; | sort -nr | head -1 > $(CF_MOD_TIME)

$(GHW): $(CF)
	@for entity in $(ENTITIES); do \
		echo "Generating $${entity}.ghw file..."; \
		ghdl -r --workdir=$(OUT_DIR) $${entity} --wave=$(ENTITY); \
	done


simulate: $(GHW)
	@for entity in $(ENTITIES); do \
		echo "Opening $${entity}.ghw in gtkwave..."; \
		open -a gtkwave $(ENTITY); \
	done

checkstructure:
	@[ -d $(OUT_DIR) ] || ( echo "Creating output directory..."; mkdir -p $(OUT_DIR) )

clear:
	@echo "Cleaning auto-generated files from output directory..."
	@rm -rf $(OUT_DIR)/*

purge:
	@echo "Purging auto-generated file structure..."
	@rm -rf $(OUT_DIR)
