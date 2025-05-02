SRC_DIR = src
BUILD_DIR = build
LIB_DIR = lib
INC_DIR = include
TARGET = Dark-Engine

CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -g -I$(INC_DIR)
LDFLAGS = -I$(INC_DIR) -L$(LIB_DIR)
LDLIBS = -lglfw3dll

LIB_FILES = $(wildcard $(LIB_DIR)/*.a)

C_SOURCES = $(wildcard $(SRC_DIR)/*.c)
CPP_SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
SOURCES = $(C_SOURCES) $(CPP_SOURCES)

OBJECTS = $(SOURCES:.c=.o)
OBJECTS := $(OBJECTS:.cpp=.o)

$(BUILD_DIR)/$(TARGET): $(OBJECTS)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)


.INTERMEDIATE: $(BUILD_DIR)/%.o
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(wildcard $(SRC_DIR)/*.o)

.INTERMEDIATE: $(SRC_DIR)/%.o