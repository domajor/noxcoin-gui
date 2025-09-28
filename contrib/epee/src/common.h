#pragma once

#include <ostream>
#include "crypto/hash.h"       // adjust the path if needed
#include "string_tools.h"      // for pod_to_hex

namespace crypto {
  namespace crypto_std {
    constexpr float sqrt(float x);
    constexpr long double sqrt(long double x);
  }
}
