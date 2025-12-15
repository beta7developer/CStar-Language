#include "include/posix_util.h"
#include <fstream>
#include <vector>

int posix_errno = 0;
std::vector<std::fstream*> fd_table;