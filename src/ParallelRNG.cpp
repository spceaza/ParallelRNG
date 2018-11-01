#include <ParallelRNG.hpp>

ParallelRNG* ParallelRNG::_instance = 0;

ParallelRNG::ParallelRNG( int size, int seed )
{
  zero = seed;
  g_seed = new int[size];
  for( int i = seed; i < ( seed + size ); ++i )
    g_seed[i - seed] = i;
}

ParallelRNG* ParallelRNG::instance( int size, int seed )
{
  if( !_instance )
    _instance = new ParallelRNG( size, seed );

  return _instance;
}

int ParallelRNG::PseudoRand( int& ind, int min, int max )
{
  g_seed[ind] = ( 214013 * g_seed[ind] + 2531011 );
  return min + ( ( ( g_seed[ind] >> 16 ) & 0x7FFF ) % ( 1 + max - min ) );
}

int ParallelRNG::PseudoRand( int min, int max )
{
  zero = ( 214013 * zero + 2531011 );
  return min + ( ( ( zero >> 16 ) & 0x7FFF ) % ( 1 + max - min ) );
}

void ParallelRNG::Reset( int size, int seed = 0 )
{
  zero = seed;
  delete[] g_seed;
  g_seed = new int[size];
  for( int i = seed; i < seed + size; ++i )
    g_seed[i - seed] = i;
}

ParallelRNG::~ParallelRNG()
{
  delete[] g_seed;
  _instance = 0;
}