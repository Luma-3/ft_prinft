###############
## 	COMPILE	 ##
###############

CC = gcc

CFLAGS = -Wall -Werror -Wextra

##############
##  SOURCE	##
##############

SRC =	flags_utils.c		\
		ft_printf.c			\
		utils.c				\
		format_function.c	\
		format_ptr.c		\
		format_hex.c		\
		format_unsigned.c	\
		specifier_utils.c

SRC_DIR = src/

################
##	OBJ/NAME  ##
################

NAME= libftprintf.a

LIBFT = libft/libft.a

OBJ_DIR = obj

OBJ_PREFIXED = $(addprefix $(OBJ_DIR)/, $(SRC:.c=.o))

INCLUDE = include

################
##	PROGRESS  ##
################

TOTAL_SRCS := $(words $(SRC))
COMPILED_SRCS := 0

##############
##	COLORS	##
##############

COLOR_RESET = \033[0m
COLOR_GREEN = \033[32m
COLOR_BLUE = \033[34m

#############
##	RULES  ##
#############

$(OBJ_DIR)/%.o: $(SRC_DIR)%.c
	@mkdir -p $(OBJ_DIR)
	@$(CC) $(CFLAGS) -I $(INCLUDE) -c $< -o $@

	@$(eval COMPILED_SRCS=$(shell echo $$(($(COMPILED_SRCS)+1))))
	@echo -n "$(COLOR_BLUE)Compiling Objects Printf: $(COLOR_RESET)[$(COLOR_GREEN)"
	@for i in $(shell seq 1 25); do \
		if [ $$i -le $$(($(COMPILED_SRCS)*25/$(TOTAL_SRCS))) ]; then \
			echo -n "♥"; \
		else \
			echo -n "."; \
		fi; \
	done
	@echo -n "$(COLOR_RESET)] $(COMPILED_SRCS)/$(TOTAL_SRCS)\r"
	
all: $(NAME)

$(NAME) : $(OBJ_PREFIXED)
	@echo "$(COLOR_BLUE)\nCompiling printf lib...$(COLOR_RESET)"
	@make -s -C libft
	@cp $(LIBFT) .
	@mv libft.a $(NAME)
	@ar rcs $(NAME) $(OBJ_PREFIXED)
	@echo "$(COLOR_GREEN)Compilation complete !$(COLOR_RESET)"
	

clean: 
	@rm -rf $(OBJ_DIR)
	@make -s -C libft clean
	@echo "$(COLOR_GREEN)Remove Object complete !$(COLOR_RESET)"

fclean: clean
	@rm -f $(NAME)
	@make -s -C libft fclean
	@echo "$(COLOR_GREEN)Remove Compilation files complete !$(COLOR_RESET)"

bonus: all

re: 
	@make -s fclean
	@make -s all 
