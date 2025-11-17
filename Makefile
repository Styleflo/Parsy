# Nom de l'exécutable principal
TARGET = markdown_parser

# Compilateur et options
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17 -O2 -Iinclude

# Dossiers
SRC_DIR = src
OBJ_DIR = build
TEST_DIR = tests

# Tous les fichiers source et objets
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRCS))

# Tous les fichiers de test et objets
TEST_SRCS = $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJS = $(patsubst $(TEST_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(TEST_SRCS))
TEST_TARGET = test_runner

# Règle par défaut : construire l'exécutable principal
all: $(TARGET)

# Création du dossier build si nécessaire
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Compilation de l'exécutable principal
$(TARGET): $(OBJ_DIR) $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS)

# Compilation des fichiers source en objets
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Compilation des tests
test: $(OBJ_DIR) $(OBJS) $(TEST_OBJS)
	$(CXX) $(CXXFLAGS) -o $(TEST_TARGET) $(OBJS) $(TEST_OBJS)

$(OBJ_DIR)/%.o: $(TEST_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Nettoyage
clean:
	rm -rf $(OBJ_DIR) $(TARGET) $(TEST_TARGET)

# Rebuild complet
re: clean all

.PHONY: all test clean re
