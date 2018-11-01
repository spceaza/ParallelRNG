#pragma once

#include <iostream>

class ParallelRNG
{
  private:
    static ParallelRNG* _instance;
    int* g_seed;
    int zero;
    int threads;

    ParallelRNG( int size, int seed = 0 );

  public:
    static ParallelRNG* instance( int size = 1, int seed = 0 );

    int PseudoRand( int&, int, int );

    int PseudoRand( int, int );

    void Reset( int, int );

    ~ParallelRNG();
};
