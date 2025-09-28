#pragma once

#if defined(__cplusplus)
#include <stdbool.h>
#include <cstddef>
#include <cstdint>
#include <cmath>
#else
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>  // <--- add this
#include <math.h>
#endif

// Avoid macro collision
static const int HASH_SIZE = 32;
static const int HASH_DATA_AREA = 136;

// Helper pointer arithmetic
static inline void* padd(void* p, size_t i) {
    return (char*)p + i;
}

static inline const void* cpadd(const void* p, size_t i) {
    return (const char*)p + i;
}

#pragma pack(push, 1)
union hash_state {
    uint8_t b[200];
    uint64_t w[25];
};
#pragma pack(pop)

static_assert(sizeof(union hash_state) == 200, "Invalid structure size");

// Core hash functions
void hash_permutation(union hash_state* state);
void hash_process(union hash_state* state, const uint8_t* buf, size_t count);

// Hash algorithms
void cn_fast_hash(const void* data, size_t length, char* hash);
void cn_slow_hash(const void* data, size_t length, char* hash, int variant, int prehashed, uint64_t height);

void hash_extra_blake(const void* data, size_t length, char* hash);
void hash_extra_groestl(const void* data, size_t length, char* hash);
void hash_extra_jh(const void* data, size_t length, char* hash);
void hash_extra_skein(const void* data, size_t length, char* hash);

// Merkle tree helpers
void tree_hash(const char (*hashes)[HASH_SIZE], size_t count, char* root_hash);
bool tree_path(size_t count, size_t idx, uint32_t* path);
bool tree_branch(const char (*hashes)[HASH_SIZE], size_t count, const char* hash, char (*branch)[HASH_SIZE], size_t* depth, uint32_t* path);
bool tree_branch_hash(const char hash[HASH_SIZE], const char (*branch)[HASH_SIZE], size_t depth, uint32_t path, char root[HASH_SIZE]);
bool is_branch_in_tree(const char hash[HASH_SIZE], const char root[HASH_SIZE], const char (*branch)[HASH_SIZE], size_t depth, uint32_t path);

#define RX_BLOCK_VERSION 12
void rx_slow_hash_allocate_state(void);
void rx_slow_hash_free_state(void);
uint64_t rx_seedheight(const uint64_t height);
void rx_seedheights(const uint64_t height, uint64_t* seed_height, uint64_t* next_height);

void rx_set_main_seedhash(const char* seedhash, size_t max_dataset_init_threads);
void rx_slow_hash(const char* seedhash, const void* data, size_t length, char* result_hash);

void rx_set_miner_thread(uint32_t value, size_t max_dataset_init_threads);
uint32_t rx_get_miner_thread(void);

// Optional: helper for floor() in C++
#if defined(__cplusplus)
static inline int int_floor_div(int value, int radix) {
    return static_cast<int>(std::floor(static_cast<float>(value) / static_cast<float>(radix)));
}
#endif
