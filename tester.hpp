#ifndef TESTER_HPP
# define TESTER_HPP

#if TEST_FLAG
	# include <iterator>
	# include <map>
	# include <set>
	# include <stack>
	# include <vector>
	namespace ft = std;
#else
	# include "./includes/iterator.hpp"
	# include "./includes/map.hpp"
	# include "./includes/set.hpp"
	# include "./includes/stack.hpp"
	# include "./includes/vector.hpp"
	# include "./includes/util.hpp"
#endif


#endif
