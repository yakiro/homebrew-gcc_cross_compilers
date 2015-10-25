require 'formula'

class I386ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2'
  sha256 '5f835b04b5f7dd4f4d2dc96190ec1621b8d89f2dc6f638f9f8bc1b1014ba8cad'
  revision 1

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'i386-elf-binutils'

  def install
    binutils = Formula.factory 'i386-elf-binutils'
    gmp = Formula.factory 'gmp'
    libmpc = Formula.factory 'libmpc'
    mpfr = Formula.factory 'mpfr'

    ENV['CC'] = '/usr/local/bin/gcc-5'
    ENV['CXX'] = '/usr/local/bin/g++-5'
    ENV['CPP'] = '/usr/local/bin/cpp-5'
    ENV['LD'] = '/usr/local/bin/gcc-5'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-elf', '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c,c++",
                             "--without-headers",
                             "--with-gmp=#{gmp.prefix}",
                             "--with-mpfr=#{mpfr.prefix}",
                             "--with-mpc=#{libmpc.prefix}"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i386-elf", prefix/"i386-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
      FileUtils.mv info/"cpp.info", info/"i386-elf-cpp.info"
      FileUtils.mv info/"cppinternals.info", info/"i386-elf-cppinternals.info"
      FileUtils.mv info/"gcc.info", info/"i386-elf-gcc.info"
      FileUtils.mv info/"gccinstall.info", info/"i386-elf-gccinstall.info"
      FileUtils.mv info/"gccint.info", info/"i386-elf-gccint.info"
    end
  end
end
