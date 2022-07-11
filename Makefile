NAME=containor

SRCS=
OBJ_DIR=./obj/
OBJS=$(SRCS:%.cpp=$(OBJDIR)%.o)
DEPS=$(SRCS:.cpp=.d)

CXX=c++
CXXFLAG=-Wall -Wextra -Werror -std=c++98 -pedantic -MMD
OUT_FILE=/dev/null
ERR_FILE=/dev/null
ACTUAL_LOG=actual_log
EXPECTED_LOG=expected_log
ACTUAL_ERR_LOG=actual_err_log
EXPCTED_ERR_LOG=expected_err_log

.cpp.o:
	$(CXX) $(CXXFLAG) -DTEST_FLAG -c $< -o $@

all: $(OBJ_DIR) $(NAME)

$(OBJ_DIR):
	mkdir -p obj

$(OBJ_DIR)%.o:%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(NAME): $(OBJS)
	$(CXX) $(CXXFLAG) $(OBJS) -o $(NAME)

clean:
	$(RM) $(OBJS)
	$(RM) $(SRCS:.cpp=.d)

fclean: clean
	$(RM)  $(NAME)

re: fclean $(NAME)

-include $(DEPS)

test: test_actual re exe_test  test_expected re exe_test
	diff $(ACTUAL_LOG) $(EXPECTED_LOG) || :
	@echo "--actual_err--"
	@cat $(ACTUAL_ERR_LOG)
	@echo "--expected_err--"
	@cat $(EXPECTED_ERR_LOG)
	


exe_test:
	./$(NAME) > $(OUT_FILE) 2>$(ERR_FILE)

test_actual:
	TEST_FLAG=1
	OUT_FILE=$(ACTUAL_LOG)
	ERR_FILE=$(ACTUAL_ERR_LOG)

test_expected:
	TEST_FLAG=0
	OUT_FILE=$(EXPECTED_LOG)
	ERR_FILE=$(EXPECTED_ERR_LOG)

.PHONY: all clean fclean re test test_actual test_expected
