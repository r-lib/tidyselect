# arrow

<details>

* Version: 0.15.1.1
* Source code: https://github.com/cran/arrow
* URL: https://github.com/apache/arrow/, https://arrow.apache.org/docs/r
* BugReports: https://issues.apache.org/jira/projects/ARROW/issues
* Date/Publication: 2019-11-05 22:00:09 UTC
* Number of recursive dependencies: 59

Run `revdep_details(,"arrow")` for more info

</details>

## Newly broken

*   checking whether package ‘arrow’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/lionel/Desktop/tidyselect/revdep/checks.noindex/arrow/new/arrow.Rcheck/00install.out’ for details.
    ```

## Newly fixed

*   checking installed package size ... NOTE
    ```
      installed size is 10.9Mb
      sub-directories of 1Mb or more:
        libs   7.7Mb
        R      3.0Mb
    ```

## Installation

### Devel

```
* installing *source* package ‘arrow’ ...
** package ‘arrow’ successfully unpacked and MD5 sums checked
** using staged installation
Downloading apache-arrow
rm: /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow: Directory not empty
Wed Jan  8 10:21:24 CET 2020: Auto-brewing apache-arrow in /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow...
Error: No available formula with the name "sphinx-doc" (dependency of apache-arrow)
Note: homebrew/core is shallow clone. To get complete history run:
  git -C "$(brew --repo homebrew/core)" fetch --unshallow

==> Searching for a previously deleted formula (in the last month)...
Error: No previously deleted formula found.
Error: No similarly named formulae found.
==> Searching taps on GitHub...
==> Searching for similarly named formulae...
==> Searching taps...
This formula was found in a tap:
homebrew/linuxbrew-core/sphinx-doc
To install it, run:
  brew install homebrew/linuxbrew-core/sphinx-doc
cp: /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/Cellar/*/*/lib/*.a: No such file or directory
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrew.a
PKG_CFLAGS=-I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW
PKG_LIBS=-L/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/lib -L/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib -lbrewparquet -lbrewarrow -lbrewthrift -lbrewlz4 -lbrewboost_system -lbrewboost_filesystem -lbrewboost_regex -lbrewdouble-conversion -lbrewsnappy
** libs
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c array.cpp -o array.o
In file included from array.cpp:18:
././arrow_types.h:184:10: fatal error: 'arrow/api.h' file not found
#include <arrow/api.h>
         ^~~~~~~~~~~~~
1 error generated.
make: *** [array.o] Error 1
ERROR: compilation failed for package ‘arrow’
* removing ‘/Users/lionel/Desktop/tidyselect/revdep/checks.noindex/arrow/new/arrow.Rcheck/arrow’

```
### CRAN

```
* installing *source* package ‘arrow’ ...
** package ‘arrow’ successfully unpacked and MD5 sums checked
** using staged installation
Downloading apache-arrow
rm: fts_read: No such file or directory
Wed Jan  8 10:21:21 CET 2020: Auto-brewing apache-arrow in /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow...
==> Tapping homebrew/core from https://github.com/autobrew/homebrew-core
Tapped 2 commands and 4646 formulae (4,903 files, 12.8MB).
double-conversion
boost
lz4
openssl
thrift
snappy
==> Downloading https://homebrew.bintray.com/bottles/double-conversion-3.1.1.mojave.bottle.tar.gz
==> Pouring double-conversion-3.1.1.mojave.bottle.tar.gz
==> Skipping post_install step for autobrew...
🍺  /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/Cellar/double-conversion/3.1.1: 21 files, 151.3KB
==> Downloading https://homebrew.bintray.com/bottles/boost-1.67.0_1.mojave.bottle.tar.gz
==> Pouring boost-1.67.0_1.mojave.bottle.tar.gz
==> Skipping post_install step for autobrew...
🍺  /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/Cellar/boost/1.67.0_1: 13,506 files, 456.4MB
==> Downloading https://homebrew.bintray.com/bottles/lz4-1.8.3.mojave.bottle.tar.gz
==> Pouring lz4-1.8.3.mojave.bottle.tar.gz
==> Skipping post_install step for autobrew...
🍺  /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/Cellar/lz4/1.8.3: 22 files, 512.7KB
==> Downloading https://homebrew.bintray.com/bottles/openssl-1.0.2p.mojave.bottle.tar.gz
==> Pouring openssl-1.0.2p.mojave.bottle.tar.gz
==> Skipping post_install step for autobrew...
==> Caveats
This formula is keg-only, which means it was not symlinked into /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow,
because Apple has deprecated use of OpenSSL in favor of its own TLS and crypto libraries.

If you need to have this software first in your PATH run:
  echo 'export PATH="/private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/opt/openssl/bin:$PATH"' >> ~/.zshrc

For compilers to find this software you may need to set:
    LDFLAGS:  -L/private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/opt/openssl/lib
    CPPFLAGS: -I/private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/opt/openssl/include
For pkg-config to find this software you may need to set:
    PKG_CONFIG_PATH: /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/opt/openssl/lib/pkgconfig

==> Summary
🍺  /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/Cellar/openssl/1.0.2p: 1,793 files, 12MB
==> Downloading https://homebrew.bintray.com/bottles/thrift-0.11.0.mojave.bottle.tar.gz
==> Pouring thrift-0.11.0.mojave.bottle.tar.gz
==> Skipping post_install step for autobrew...
==> Caveats
To install Ruby binding:
  gem install thrift
==> Summary
🍺  /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/Cellar/thrift/0.11.0: 102 files, 7MB
==> Downloading https://homebrew.bintray.com/bottles/snappy-1.1.7_1.mojave.bottle.tar.gz
==> Pouring snappy-1.1.7_1.mojave.bottle.tar.gz
==> Skipping post_install step for autobrew...
🍺  /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/Cellar/snappy/1.1.7_1: 18 files, 115.8KB
==> Downloading https://autobrew.github.io/bottles/apache-arrow-0.15.1.el_capitan.bottle.tar.gz
==> Pouring apache-arrow-0.15.1.el_capitan.bottle.tar.gz
==> Skipping post_install step for autobrew...
🍺  /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/Cellar/apache-arrow/0.15.1: 238 files, 35MB
==> Caveats
==> openssl
This formula is keg-only, which means it was not symlinked into /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow,
because Apple has deprecated use of OpenSSL in favor of its own TLS and crypto libraries.

If you need to have this software first in your PATH run:
  echo 'export PATH="/private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/opt/openssl/bin:$PATH"' >> ~/.zshrc

For compilers to find this software you may need to set:
    LDFLAGS:  -L/private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/opt/openssl/lib
    CPPFLAGS: -I/private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/opt/openssl/include
For pkg-config to find this software you may need to set:
    PKG_CONFIG_PATH: /private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/build-apache-arrow/opt/openssl/lib/pkgconfig

==> thrift
To install Ruby binding:
  gem install thrift
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewarrow.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewarrow_dataset.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewparquet.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_atomic-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_chrono-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_chrono.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_container-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_container.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_context-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_contract-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_contract.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_coroutine-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_coroutine.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_date_time-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_date_time.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_exception-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_exception.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_fiber-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_filesystem-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_filesystem.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_graph-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_graph.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_iostreams-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_iostreams.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_locale-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_log-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_log.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_log_setup-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_log_setup.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_c99-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_c99.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_c99f-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_c99f.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_c99l-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_c99l.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_tr1-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_tr1.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_tr1f-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_tr1f.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_tr1l-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_math_tr1l.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_prg_exec_monitor-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_prg_exec_monitor.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_program_options-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_program_options.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_random-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_random.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_regex-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_regex.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_serialization-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_serialization.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_signals-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_signals.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_stacktrace_addr2line-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_stacktrace_addr2line.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_stacktrace_basic-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_stacktrace_basic.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_stacktrace_noop-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_stacktrace_noop.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_system-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_system.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_test_exec_monitor-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_test_exec_monitor.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_thread-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_timer-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_timer.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_type_erasure-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_type_erasure.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_unit_test_framework-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_unit_test_framework.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_wave-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_wserialization-mt.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewboost_wserialization.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewdouble-conversion.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewlz4.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewcrypto.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewssl.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewsnappy.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewthrift.a
created /var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib/libbrewthriftz.a
PKG_CFLAGS=-I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW
PKG_LIBS=-L/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/lib -L/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib -lbrewparquet -lbrewarrow -lbrewthrift -lbrewlz4 -lbrewboost_system -lbrewboost_filesystem -lbrewboost_regex -lbrewdouble-conversion -lbrewsnappy
** libs
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c array.cpp -o array.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c array_from_vector.cpp -o array_from_vector.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c array_to_vector.cpp -o array_to_vector.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c arraydata.cpp -o arraydata.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c arrowExports.cpp -o arrowExports.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c buffer.cpp -o buffer.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c chunkedarray.cpp -o chunkedarray.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c compression.cpp -o compression.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c compute.cpp -o compute.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c csv.cpp -o csv.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c datatype.cpp -o datatype.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c feather.cpp -o feather.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c field.cpp -o field.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c filesystem.cpp -o filesystem.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c io.cpp -o io.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c json.cpp -o json.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c memorypool.cpp -o memorypool.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c message.cpp -o message.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c parquet.cpp -o parquet.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c recordbatch.cpp -o recordbatch.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c recordbatchreader.cpp -o recordbatchreader.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c recordbatchwriter.cpp -o recordbatchwriter.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c schema.cpp -o schema.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c symbols.cpp -o symbols.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c table.cpp -o table.o
clang++ -std=gnu++11 -std=c++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG -I/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/include -DARROW_R_WITH_ARROW -I"/Users/lionel/Desktop/tidyselect/revdep/library.noindex/arrow/Rcpp/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include  -fPIC  -Wall -g -O2  -arch x86_64 -ftemplate-depth-256 -Wall -pedantic -c threadpool.cpp -o threadpool.o
clang++ -std=gnu++11 -std=c++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/usr/local/lib -o arrow.so array.o array_from_vector.o array_to_vector.o arraydata.o arrowExports.o buffer.o chunkedarray.o compression.o compute.o csv.o datatype.o feather.o field.o filesystem.o io.o json.o memorypool.o message.o parquet.o recordbatch.o recordbatchreader.o recordbatchwriter.o schema.o symbols.o table.o threadpool.o -L/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/opt/apache-arrow/lib -L/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T//build-apache-arrow/lib -lbrewparquet -lbrewarrow -lbrewthrift -lbrewlz4 -lbrewboost_system -lbrewboost_filesystem -lbrewboost_regex -lbrewdouble-conversion -lbrewsnappy -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
installing to /Users/lionel/Desktop/tidyselect/revdep/checks.noindex/arrow/old/arrow.Rcheck/00LOCK-arrow/00new/arrow/libs
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
** checking absolute paths in shared objects and dynamic libraries
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (arrow)

```
# AzureKusto

<details>

* Version: 1.0.4
* Source code: https://github.com/cran/AzureKusto
* URL: https://github.com/Azure/AzureKusto https://github.com/Azure/AzureR
* BugReports: https://github.com/Azure/AzureKusto/issues
* Date/Publication: 2019-10-26 22:30:08 UTC
* Number of recursive dependencies: 67

Run `revdep_details(,"AzureKusto")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
       10. AzureKusto::flatten_query(op$ops) revdep/checks.noindex/AzureKusto/new/AzureKusto.Rcheck/00_pkg_src/AzureKusto/R/kql-build.R:12:4
       12. AzureKusto:::op_vars.op_rename(flat_op) revdep/checks.noindex/AzureKusto/new/AzureKusto.Rcheck/00_pkg_src/AzureKusto/R/ops.R:230:11
       13. tidyselect::vars_rename(op_vars(op$x), !!!op$dots) revdep/checks.noindex/AzureKusto/new/AzureKusto.Rcheck/00_pkg_src/AzureKusto/R/ops.R:247:4
       14. tidyselect:::rename_impl(NULL, .vars, quo(c(...)), strict = .strict)
       15. tidyselect:::eval_select_impl(...)
       16. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 100 | SKIPPED: 7 | WARNINGS: 3 | FAILED: 3 ]
      1. Failure: filter errors on missing symbols (@test_translate.r#96) 
      2. Failure: select errors on column after selected away (@test_translate.r#139) 
      3. Failure: rename() errors when given a nonexistent column (@test_translate.r#282) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tibble’
      All declared Imports should be used.
    ```

# cattonum

<details>

* Version: 0.0.3
* Source code: https://github.com/cran/cattonum
* URL: https://github.com/bfgray3/cattonum
* BugReports: https://github.com/bfgray3/cattonum/issues
* Date/Publication: 2019-12-17 14:10:09 UTC
* Number of recursive dependencies: 72

Run `revdep_details(,"cattonum")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(cattonum)
      > 
      > test_check("cattonum")
      ── 1. Failure: conditions work correctly. (@test-conditions.R#7)  ──────────────
      `catto_label(foo, one_of(x1, x2))` did not throw an error.
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 254 | SKIPPED: 4 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: conditions work correctly. (@test-conditions.R#7) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘purrr’
      All declared Imports should be used.
    ```

# cheese

<details>

* Version: 0.0.1
* Source code: https://github.com/cran/cheese
* URL: https://github.com/zajichek/cheese
* Date/Publication: 2019-04-01 08:10:03 UTC
* Number of recursive dependencies: 91

Run `revdep_details(,"cheese")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    +         by = -matches("^(S|H)")
    + )
    Error: Selections can't have negative values.
    <error/rlang_error>
    Selections can't have negative values.
    Backtrace:
         █
      1. └─heart_disease %>% select(Sex, HeartDisease, BloodSugar) %>% divide(by = -matches("^(S|H)"))
      2.   ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
      3.   └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      4.     └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
      5.       └─`_fseq`(`_lhs`)
      6.         └─magrittr::freduce(value, `_function_list`)
      7.           ├─base::withVisible(function_list[[k]](value))
      8.           └─function_list[[k]](value)
      9.             └─cheese::divide(., by = -matches("^(S|H)"))
     10.               └─data %>% dplyr::select(by) 00_pkg_src/cheese/R/FUNCTIONS.R:16:8
     11.                 ├─base::withVisible(eval(quote(`_fseq`(`_lhs`)), env, env))
     12.                 └─base::eval(quote(`_fseq`(`_lhs`)), env, env)
     13.                   └─base::eval(quote(`_fseq`(`_lhs`))
    Execution halted
    ```

# cursory

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/cursory
* URL: https://github.com/halpo/cursory
* BugReports: https://github.com/halpo/cursory/issues
* Date/Publication: 2019-08-22 08:40:02 UTC
* Number of recursive dependencies: 63

Run `revdep_details(,"cursory")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    Must select existing columns.
    ✖ Can't subset elements with unknown names `Key` and `~`.
    Backtrace:
        █
     1. └─cursory::table_1(iris, Species)
     2.   └─tidyselect::vars_select(...) 00_pkg_src/cursory/R/table_1.R:41:4
     3.     └─tidyselect:::eval_select_impl(...)
     4.       └─tidyselect:::subclass_index_errors(...)
    <parent: error/vctrs_error_subscript_oob_name>
    Must index existing elements.
    ✖ Can't subset elements with unknown names `Key` and `~`.
    Backtrace:
         █
      1. ├─tidyselect:::sanitise_base_errors(expr)
      2. │ └─base::withCallingHandlers(...)
      3. ├─tidyselect:::vars_select_eval(...)
      4. │ └─tidyselect:::walk_data_tree(expr, data_mask, context_mask)
      5. │   └─tidyselect:::eval_and(expr, data_mask, context_mask)
      6. │     └─tidyselect:::walk_operand(y, data_mask, context_mask)
      7. │
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ✖ Can't subset elements with unknown names `Key` and `~`.
      Backtrace:
       1. cursory::table_1(...)
       2. tidyselect::vars_select(...) revdep/checks.noindex/cursory/new/cursory.Rcheck/00_pkg_src/cursory/R/table_1.R:41:4
       3. tidyselect:::eval_select_impl(...)
       4. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 118 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: table_1 (@table_1.R#54) 
      
      Error: testthat unit tests failed
      In addition: Warning message:
      call dbDisconnect() when finished working with a connection 
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘tibble’
      All declared Imports should be used.
    ```

# dplyr

<details>

* Version: 0.8.3
* Source code: https://github.com/cran/dplyr
* URL: http://dplyr.tidyverse.org, https://github.com/tidyverse/dplyr
* BugReports: https://github.com/tidyverse/dplyr/issues
* Date/Publication: 2019-07-04 15:50:02 UTC
* Number of recursive dependencies: 94

Run `revdep_details(,"dplyr")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... WARNING
    ```
    '::' or ':::' import not declared from: ‘ellipsis’
    ```

## In both

*   checking examples ... ERROR
    ```
    ...
    + 
    +   # Compute query and save in remote table
    +   compute(remote)
    + 
    +   # Compute query bring back to this session
    +   collect(remote)
    + 
    +   # Creates a fresh query based on the generated SQL
    +   collapse(remote)
    + }
    Loading required package: dbplyr
    
    Attaching package: ‘dbplyr’
    
    The following objects are masked from ‘package:dplyr’:
    
        ident, sql
    
    Error in loadNamespace(name) : there is no package called ‘RSQLite’
    Calls: %>% ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      7: loadNamespace(name)
      8: withRestarts(stop(cond), retry_loadNamespace = function() NULL)
      9: withOneRestart(expr, restarts[[1L]])
      10: doWithOneRestart(return(expr), restart)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 3396 | SKIPPED: 15 | WARNINGS: 1 | FAILED: 5 ]
      1. Error: arrange supports bit64::integer64 (#4366) (@test-arrange.r#199) 
      2. Error: *_(all,at) handle utf-8 names (#2967) (@test-colwise-mutate.R#263) 
      3. Failure: colwise mutate gives correct error message if column not found (#4374) (@test-colwise-mutate.R#430) 
      4. Error: combine works with integer64 (#1092) (@test-combine.R#192) 
      5. Error: auto_copy() requires same source (@test-copy_to.R#41) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking package dependencies ... NOTE
    ```
    Packages suggested but not available for checking:
      'bit64', 'dtplyr', 'Lahman', 'microbenchmark', 'nycflights13', 'RMySQL',
      'RPostgreSQL', 'RSQLite'
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  5.3Mb
      sub-directories of 1Mb or more:
        libs   2.8Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘dtplyr’, ‘microbenchmark’, ‘RMySQL’, ‘RPostgreSQL’, ‘RSQLite’
    ```

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 4 marked UTF-8 strings
    ```

# dtplyr

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/dtplyr
* URL: https://github.com/tidyverse/dtplyr
* BugReports: https://github.com/tidyverse/dtplyr/issues
* Date/Publication: 2019-11-12 09:30:02 UTC
* Number of recursive dependencies: 60

Run `revdep_details(,"dtplyr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ── 1. Error: renames grouping vars (@test-step-call.R#49)  ─────────────────────
      Names must be unique.
      Backtrace:
       1. testthat::expect_equal(rename(gt, y = x)$groups, "y")
       5. dtplyr:::rename.dtplyr_step(gt, y = x)
       6. tidyselect::vars_rename(.data$vars, ...) revdep/checks.noindex/dtplyr/new/dtplyr.Rcheck/00_pkg_src/dtplyr/R/step-call.R:40:2
       7. tidyselect:::rename_impl(NULL, .vars, quo(c(...)), strict = .strict)
       8. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 187 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: renames grouping vars (@test-step-call.R#49) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# jpndistrict

<details>

* Version: 0.3.4
* Source code: https://github.com/cran/jpndistrict
* URL: https://uribo.github.io/jpndistrict/
* BugReports: https://github.com/uribo/jpndistrict/issues
* Date/Publication: 2019-05-23 06:20:03 UTC
* Number of recursive dependencies: 102

Run `revdep_details(,"jpndistrict")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘jpndistrict-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: jpn_cities
    > ### Title: Simple features for city area polygons
    > ### Aliases: jpn_cities
    > 
    > ### ** Examples
    > 
    > jpn_cities(jis_code = "08",
    +   admin_name = intToUtf8(c(12388, 12367, 12400, 24066)))
    Warning in x:y :
      numerical expression has 4 elements: only the first used
    Warning in x:y :
      numerical expression has 4 elements: only the first used
    Error: Result must have length 44, not 0
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      options:        ENCODING=cp932 
      Reading layer `P34-14_47' from data source `/private/var/folders/b9/1vbq6rn93_1fk71sn95dqb8r0000gn/T/Rtmpixben3/P34-14_47_GML/P34-14_47.shp' using driver `ESRI Shapefile'
      Simple feature collection with 65 features and 4 fields
      geometry type:  POINT
      dimension:      XY
      bbox:           xmin: 123.0045 ymin: 24.06092 xmax: 131.2989 ymax: 27.03917
      epsg (SRID):    4612
      proj4string:    +proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 85 | SKIPPED: 1 | WARNINGS: 4 | FAILED: 2 ]
      1. Error: (unknown) (@test-export.R#3) 
      2. Error: jpn_cities (@test-spdf_jpn.R#66) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 188 marked UTF-8 strings
    ```

# mudata2

<details>

* Version: 1.0.7
* Source code: https://github.com/cran/mudata2
* URL: https://github.com/paleolimbot/mudata
* BugReports: https://github.com/paleolimbot/mudata/issues
* Date/Publication: 2019-08-29 21:10:02 UTC
* Number of recursive dependencies: 93

Run `revdep_details(,"mudata2")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 13 lines of output:
      OGR: Unsupported geometry type
      OGR: Unsupported geometry type
      OGR: Unsupported geometry type
      OGR: Unsupported geometry type
      OGR: Unsupported geometry type
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 956 | SKIPPED: 0 | WARNINGS: 8 | FAILED: 5 ]
      1. Failure: rename functions throw errors (@test_rename.R#50) 
      2. Failure: rename functions throw errors (@test_rename.R#51) 
      3. Failure: rename functions throw errors (@test_rename.R#52) 
      4. Failure: rename functions throw errors (@test_rename.R#53) 
      5. Error: rename functions throw errors (@test_rename.R#60) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# plyranges

<details>

* Version: 1.4.4
* Source code: https://github.com/cran/plyranges
* BugReports: https://github.com/sa-lee/plyranges
* Date/Publication: 2019-09-17
* Number of recursive dependencies: 121

Run `revdep_details(,"plyranges")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Attributes: < Component "elementMetadata": Lengths: 2, 1 >
      Attributes: < Component "elementMetadata": names for target but not for current >
      Attributes: < Component "elementMetadata": Attributes: < Modes: list, NULL > >
      Attributes: < Component "elementMetadata": Attributes: < Lengths: 7, 0 > >
      Attributes: < Component "elementMetadata": Attributes: < names for target but not for current > >
      Attributes: < Component "elementMetadata": Attributes: < current is not list-like > >
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 307 | SKIPPED: 0 | WARNINGS: 12 | FAILED: 3 ]
      1. Failure: reordering/dropping works as expected (@test-select.R#40) 
      2. Failure: dropping everything sets mcols slot to empty (@test-select.R#53) 
      3. Failure: dropping everything sets mcols slot to empty (@test-select.R#55) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# probably

<details>

* Version: 0.0.3
* Source code: https://github.com/cran/probably
* URL: https://github.com/tidymodels/probably/
* BugReports: https://github.com/tidymodels/probably/issues
* Date/Publication: 2019-07-07 22:40:03 UTC
* Number of recursive dependencies: 85

Run `revdep_details(,"probably")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      `manual_creation_eq[1:6]` threw an error with unexpected message.
      Expected match: "5 and you've tried to subset element 6"
      Actual message: "Must index existing elements.\n✖ Can't subset position 6.\nℹ There are only 5 elements."
      Backtrace:
        1. testthat::expect_error(manual_creation_eq[1:6], "5 and you've tried to subset element 6")
       10. vctrs::stop_subscript_oob_location(i = i, size = size)
       11. vctrs:::stop_subscript_oob(...)
       12. vctrs:::stop_subscript(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 116 | SKIPPED: 0 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: slicing (@test-class-pred.R#212) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘parsnip’
    ```

# RSDA

<details>

* Version: 3.0
* Source code: https://github.com/cran/RSDA
* URL: http://www.oldemarrodriguez.com
* Date/Publication: 2019-10-22 05:30:02 UTC
* Number of recursive dependencies: 127

Run `revdep_details(,"RSDA")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘RSDA-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: Cardiological
    > ### Title: Cardiological data example
    > ### Aliases: Cardiological
    > ### Keywords: datasets
    > 
    > ### ** Examples
    > 
    > data(Cardiological)
    > res.cm <- sym.lm(formula = Pulse~Syst+Diast, sym.data = Cardiological, method = 'cm')
    Error in vec_equal_na(x) : Unimplemented type in `vctrs_equal_na()`.
    Calls: sym.lm ... vec_cast.list.default -> vec_slice<- -> vec_equal_na
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Backtrace:
        1. testthat::expect_true(...)
       16. vctrs:::vec_cast.list.default(...)
       18. vctrs::vec_equal_na(x)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 16 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 5 ]
      1. Failure: multiplication works (@test-read_sym_table.R#9) 
      2. Failure: multiplication works (@test-read_sym_table.R#11) 
      3. Error: Variance (@test-stats.R#17) 
      4. Error: Standard Deviation (@test-stats.R#24) 
      5. Error: Corralation (@test-stats.R#31) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

# tibbleOne

<details>

* Version: 0.1.0
* Source code: https://github.com/cran/tibbleOne
* Date/Publication: 2019-10-28 15:10:02 UTC
* Number of recursive dependencies: 108

Run `revdep_details(,"tibbleOne")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Names must be unique.
      Backtrace:
        1. tibbleOne::to_kable(tb1, format = "latex")
        2. [ `%<>%`(...) ] with 7 more calls revdep/checks.noindex/tibbleOne/new/tibbleOne.Rcheck/00_pkg_src/tibbleOne/R/to_kable.R:225:6
       11. dplyr:::rename.data.frame(., !!!names_to_repair)
       12. tidyselect::vars_rename(names(.data), !!!enquos(...))
       13. tidyselect:::rename_impl(NULL, .vars, quo(c(...)), strict = .strict)
       14. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 36 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 1 ]
      1. Error: correct inputs work (@test-to_kable.R#38) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘lifecycle’
      All declared Imports should be used.
    ```

# tidyr

<details>

* Version: 1.0.0
* Source code: https://github.com/cran/tidyr
* URL: https://tidyr.tidyverse.org, https://github.com/tidyverse/tidyr
* BugReports: https://github.com/tidyverse/tidyr/issues
* Date/Publication: 2019-09-11 23:00:03 UTC
* Number of recursive dependencies: 62

Run `revdep_details(,"tidyr")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      
      ── 5. Failure: values_summarize applied even when no-duplicates (@test-pivot-wid
      pv$x not equal to list_of(1L, 2L).
      Attributes: < target is NULL, current is list >
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 557 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 5 ]
      1. Failure: can nest multiple columns (@test-nest.R#80) 
      2. Failure: can nest multiple columns (@test-nest.R#81) 
      3. Failure: duplicated keys produce list column with warning (@test-pivot-wide.R#73) 
      4. Failure: warning suppressed by supplying values_fn (@test-pivot-wide.R#87) 
      5. Failure: values_summarize applied even when no-duplicates (@test-pivot-wide.R#99) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

## In both

*   checking data for non-ASCII characters ... NOTE
    ```
      Note: found 24 marked UTF-8 strings
    ```

# tsibble

<details>

* Version: 0.8.5
* Source code: https://github.com/cran/tsibble
* URL: https://tsibble.tidyverts.org
* BugReports: https://github.com/tidyverts/tsibble/issues
* Date/Publication: 2019-11-03 06:00:02 UTC
* Number of recursive dependencies: 94

Run `revdep_details(,"tsibble")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Expected match: "Unknown column"
      Actual message: "Must select existing columns.\n✖ Can't subset element with unknown name `value1`."
      Backtrace:
        1. testthat::expect_error(fill_gaps(tsbl, value1 = value), "Unknown column")
        7. tsibble:::fill_gaps.tbl_ts(tsbl, value1 = value) revdep/checks.noindex/tsibble/new/tsibble.Rcheck/00_pkg_src/tsibble/R/gaps.R:66:2
        8. tidyselect::vars_select(measured_vars(.data), !!!names(lst_exprs)) revdep/checks.noindex/tsibble/new/tsibble.Rcheck/00_pkg_src/tsibble/R/gaps.R:85:4
        9. tidyselect:::eval_select_impl(...)
       10. tidyselect:::subclass_index_errors(...)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 789 | SKIPPED: 2 | WARNINGS: 1 | FAILED: 1 ]
      1. Failure: a tbl_ts of 4 day interval with bad names (@test-gaps.R#74) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

