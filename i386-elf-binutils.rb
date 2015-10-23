require 'formula'

class I386ElfBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.23.tar.gz'
  sha1 '470c388c97ac8d216de33fa397d7be9f96c3fe04'

  depends_on 'gcc' => :build

  def install
    ENV['CC'] = '/usr/local/bin/gcc-5.2'
    ENV['CXX'] = '/usr/local/bin/g++-5.2'
    ENV['CPP'] = '/usr/local/bin/cpp-5.2'
    ENV['LD'] = '/usr/local/bin/gcc-5.2'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-elf',
                             '--disable-werror',
                             '--enable-gold=yes',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
      FileUtils.mv lib, libexec
    end
  end

end
