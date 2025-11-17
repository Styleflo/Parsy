# Nom de l'exécutable final
TARGET = mon_programme

# Compilateur et options
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17 -O2

# Tous les fichiers source
SRCS = $(wildcard *.cpp)

# Les fichiers objets correspondants
OBJS = $(SRCS:.cpp=.o)

# Règle par défaut : construire l'exécutable
all: $(TARGET)

# Construction de l'exécutable à partir des objets
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

# Compilation des fichiers source en objets
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Nettoyage des fichiers objets et de l'exécutable
clean:
	rm -f $(OBJS) $(TARGET)

# Rebuild complet
re: clean all

# Cible "phony" pour éviter les conflits avec des fichiers du même nom
.PHONY: all clean re
