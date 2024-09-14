class Cppinsights < Formula
  desc "See your source code with the eyes of a compiler"
  homepage "https://cppinsights.io/"
  url "https://github.com/andreasfertig/cppinsights/archive/refs/tags/v_17.0.tar.gz"
  sha256 "2dd6bcfcdba65c0ed2e1f04ef79d57285186871ad8bd481d63269f3115276216"
  license "MIT"
  revision 1

  bottle do
    sha256 cellar: :any,                 arm64_sequoia:  "a98eb7b557dfbbec2513985ca276c36ac0d3850d278ecdb5d7d17ed6337aa279"
    sha256 cellar: :any,                 arm64_sonoma:   "a73346fbd9edb64521a44f884289097c82361f2a0a459705dad0e8981b2f74fa"
    sha256 cellar: :any,                 arm64_ventura:  "3a1594c14be75f743a274b8f3e4093b122260d4ec82c9d67596f1141ce83d455"
    sha256 cellar: :any,                 arm64_monterey: "a1ce431bab70c47c4ec36092a09239b4786c45d1971ea1a4b670c15f8761fb60"
    sha256 cellar: :any,                 sonoma:         "05ebd00bb3dd6a28675df46610cb8e3713aa4a77395d7bb9dcc6ee1a70dd96e8"
    sha256 cellar: :any,                 ventura:        "847ad399da7cd8e1041a27a49ae0045257683e898116afff9f802cde794d8cd9"
    sha256 cellar: :any,                 monterey:       "a8abb0ff037bb8cefd1b94d7aff08f0afbc4923eb740c7bdb9cc69acc17c99c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "04c0af7c3a2ca0b57f47099782d2bd08ab2148ef13e84f978c4a571cc8e695e1"
  end

  depends_on "cmake" => :build
  depends_on "llvm@18"
  on_macos do
    depends_on "llvm" => :build if DevelopmentTools.clang_build_version <= 1500
  end

  fails_with :clang do
    build 1500
    cause "Requires Clang 16 or later"
  end

  def install
    ENV.llvm_clang if ENV.compiler == :clang && DevelopmentTools.clang_build_version <= 1500

    system "cmake", "-S", ".", "-B", "build", "-DINSIGHTS_LLVM_CONFIG=#{Formula["llvm@18"].opt_bin}/llvm-config",
           "-DINSIGHTS_USE_SYSTEM_INCLUDES=Off", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      int main() {
        int arr[5]{2,3,4};
      }
    EOS
    assert_match "{2, 3, 4, 0, 0}", shell_output("#{bin}/insights ./test.cpp")
  end
end
