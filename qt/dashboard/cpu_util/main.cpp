/*
How to get total cpu usage in Linux using C++
( https://stackoverflow.com/a/49902119 )
g++ -std=c++11 -o CPUUsage main.cpp CPUSnapshot.cpp CPUData.cpp
 */
#include "CPUSnapshot.h"

#include <chrono>
#include <thread>
#include <iostream>

int main()
{
  CPUSnapshot previousSnap;
  std::this_thread::sleep_for(std::chrono::milliseconds(1000));
  CPUSnapshot curSnap;

  const float ACTIVE_TIME = curSnap.GetActiveTimeTotal() - previousSnap.GetActiveTimeTotal();
  const float IDLE_TIME   = curSnap.GetIdleTimeTotal() - previousSnap.GetIdleTimeTotal();
  const float TOTAL_TIME  = ACTIVE_TIME + IDLE_TIME;
  int usage = 100.f * ACTIVE_TIME / TOTAL_TIME;
  std::cout << "total cpu usage: " << usage << std::endl;
}
