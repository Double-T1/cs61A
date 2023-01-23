/**
 * @brief
 * a class structure that maintains the top n grestest value
 *
 */

#include <vector>
#include <queue>
#include <set>

class TopN
{
private:
    ordered_set<int> s;
    int size = 0;

public:
    TopN(int n) : size(n) {}

    void insert(int val)
    {
        s.insert(val);
        if (s.size() > size)
            s.erase(s.begin());
    }

    int top()
    {
        return *s.rbeign();
    }
};