class HuggingfaceCli < Formula
  include Language::Python::Virtualenv

  desc "Client library for huggingface.co hub"
  homepage "https://huggingface.co/docs/huggingface_hub/index"
  url "https://files.pythonhosted.org/packages/ce/6c/bbffe9299f03deb2c725eb67f1f7eede207bbbfc15a3cba0ff8dabfe26a9/huggingface_hub-0.23.5.tar.gz"
  sha256 "67a9caba79b71235be3752852ca27da86bd54311d2424ca8afdb8dda056edf98"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any,                 arm64_sonoma:   "4fa5576fe7adaf4495c1f13910e352f92273b5d14b8e716a43b870fca3803cbe"
    sha256 cellar: :any,                 arm64_ventura:  "dffc4f204b6b1e5f4591bf54a3b782bcecc3ef5f34ec13ec01506bfdd1400831"
    sha256 cellar: :any,                 arm64_monterey: "a2ff5dd8955312b68bf75d8f3efa87830f213c8bc6ba3e9b95ec6fe17380f46a"
    sha256 cellar: :any,                 sonoma:         "4e572cc320f25aa9793abe6d0aa955794833519559601f3c589407586d600342"
    sha256 cellar: :any,                 ventura:        "f9be49a76bb64d66121ed1695b0cca9e736ca64083bfcee045d0d840c8c3a985"
    sha256 cellar: :any,                 monterey:       "2b4b2b8891326ec7293e1d2ba8f9d0387bf360bef85dd50f957ac624a1656d92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "59e78aedb4f155e8a493705c54d0f0388af06dea5c0ed37ac9892ca5327d4664"
  end

  depends_on "certifi"
  depends_on "git-lfs"
  depends_on "libyaml"
  depends_on "python@3.12"

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/63/09/c1bc53dab74b1816a00d8d030de5bf98f724c52c1635e07681d312f20be8/charset-normalizer-3.3.2.tar.gz"
    sha256 "f30c3cb33b24454a82faecaf01b19c18562b1e89558fb6c56de4d9118a032fd5"
  end

  resource "filelock" do
    url "https://files.pythonhosted.org/packages/08/dd/49e06f09b6645156550fb9aee9cc1e59aba7efbc972d665a1bd6ae0435d4/filelock-3.15.4.tar.gz"
    sha256 "2207938cbc1844345cb01a5a95524dae30f0ce089eba5b00378295a17e3e90cb"
  end

  resource "fsspec" do
    url "https://files.pythonhosted.org/packages/90/b6/eba5024a9889fcfff396db543a34bef0ab9d002278f163129f9f01005960/fsspec-2024.6.1.tar.gz"
    sha256 "fad7d7e209dd4c1208e3bbfda706620e0da5142bebbd9c384afb95b07e798e49"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/21/ed/f86a79a07470cb07819390452f178b3bef1d375f2ec021ecfc709fc7cf07/idna-3.7.tar.gz"
    sha256 "028ff3aadf0609c1fd278d8ea3089299412a7a8b9bd005dd08b9f8285bcb5cfc"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/51/65/50db4dda066951078f0a96cf12f4b9ada6e4b811516bf0262c0f4f7064d4/packaging-24.1.tar.gz"
    sha256 "026ed72c8ed3fcce5bf8950572258698927fd1dbda10a5e981cdf0ac37f4f002"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/cd/e5/af35f7ea75cf72f2cd079c95ee16797de7cd71f29ea7c68ae5ce7be1eda0/PyYAML-6.0.1.tar.gz"
    sha256 "bfdf460b1736c775f2ba9f6a92bca30bc2095067b8a9d77876d1fad6cc3b4a43"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896afe06353c2a2913/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/5a/c0/b7599d6e13fe0844b0cda01b9aaef9a0e87dbb10b06e4ee255d3fa1c79a2/tqdm-4.66.4.tar.gz"
    sha256 "e4d936c9de8727928f3be6079590e97d9abfe8d39a590be678eb5919ffc186bb"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/df/db/f35a00659bc03fec321ba8bce9420de607a1d37f8342eee1863174c69557/typing_extensions-4.12.2.tar.gz"
    sha256 "1a7ead55c7e559dd4dee8856e3a88b41225abfe1ce8df57b7c13915fe121ffb8"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/43/6d/fa469ae21497ddc8bc93e5877702dca7cb8f911e337aca7452b5724f1bb6/urllib3-2.2.2.tar.gz"
    sha256 "dd505485549a7a552833da5e6063639d0d177c04f23bc3864e41e5dc5f612168"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    whoami_output = shell_output("#{bin}/huggingface-cli whoami")
    assert_match "Not logged in", whoami_output
    test_cache = testpath/"cache"
    test_cache.mkdir
    ENV["HUGGINGFACE_HUB_CACHE"] = test_cache.to_s
    ENV["NO_COLOR"] = "1"
    scan_output = shell_output("#{bin}/huggingface-cli scan-cache")
    assert_match "Done in 0.0s. Scanned 0 repo(s) for a total of 0.0.", scan_output
  end
end
