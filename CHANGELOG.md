# win32-mmap Changelog

<!-- latest_release 0.4.3 -->
## [win32-mmap-0.4.3](https://github.com/chef/win32-mmap/tree/win32-mmap-0.4.3) (2025-06-20)

#### Merged Pull Requests
- Adding Ruby 3.4 and Cookstyle support [#19](https://github.com/chef/win32-mmap/pull/19) ([johnmccrae](https://github.com/johnmccrae))
<!-- latest_release -->
<!-- release_rollup since=0.4.2 -->
### Changes not yet released to rubygems.org

#### Merged Pull Requests
- Adding Ruby 3.4 and Cookstyle support [#19](https://github.com/chef/win32-mmap/pull/19) ([johnmccrae](https://github.com/johnmccrae)) <!-- 0.4.3 -->
- Ruby Version Support for 3.4.2 [#18](https://github.com/chef/win32-mmap/pull/18) ([johnmccrae](https://github.com/johnmccrae)) <!-- 0.4.3 -->
<!-- release_rollup -->

<!-- latest_stable_release -->
== 0.4.2 - 12-Nov-2015
* Added a win32-mmap.rb file for convenience.
* This gem is now signed.
* Use require_relative where appropriate.
* Added an appveyor.yml file for the MS continuous integration service.
* The gem tasks in the Rakefile now assume Rubygems 2.x.
* References to the rubyforge_project in the gemspec were removed.
<!-- latest_stable_release -->

== 0.4.1 - 21-Oct-2013
* Fixed the INVALID_HANDLE_VALUE constant for 64-bit Ruby.
* Added rake and test-unit as development dependencies.

== 0.4.0 - 21-Aug-2013
* Added methods for reading or writing raw strings to the underlying
  memory mapped file (as opposed to marshalled data). Thanks go to
  Frank Quednau for the patch.

== 0.3.2 - 28-Apr-2013
* Fixed a prototype mismatch in a call to CreateFile. Thanks go to
  Frank Quednau for the spot.

== 0.3.1 - 26-Apr-2013
* Added the missing OPEN_ALWAYS constant. Thanks go to Frank Quednau.
* Set the dependency properly (ffi now, not windows-pr).

== 0.3.0 - 10-Apr-2013
* Converted code to use FFI.

== 0.2.4 - 28-Apr-2010
* The Rakefile was refactored. It now handles gem creation, building and
  cleanup.
* Inline code was removed from the gemspec.

== 0.2.3 - 12-Aug-2009
* Changed license to Artistic 2.0.
* The MMap.open method now properly handles a block.
* Some gemspec updates, including the license and description.
* Changed test and example file names.
* Some Rakefile updates, including tasks for running example programs.

== 0.2.2 - 16-May-2007
* Fixed a bug where marshalled data that happened to end with a "\0" would
  cause the getter to fail.
* Now runs -w clean.
* Added more tests.
* Removed the install.rb file. Installation is now handled via the 'rake
  install' task.
* Updated the MANIFEST file and made it rdoc friendly.

== 0.2.1 - 22-Oct-2006
* Removed the custom memcpy function since that function now does the right
  thing regardless of argument type.
* Now requires windows-pr 0.5.6 or later (to take advantage of the improved
  memcpy).

== 0.2.0 - 13-Oct-2006
* Completely scrapped the old interface and code.  It is now pure Ruby and
  has a much different API, and some internal changes.
* Added a gemspec and an install.rb file for manual installation.
* Now requires the windows-pr package, 0.5.5 or higher.
* Modified the example scripts.
* Updated the docs, and replaced the .txt and .rd files with a single .rdoc
  file.

== 0.1.1 - 1-Mar-2005
* Moved the 'examples' directory to the toplevel directory.
* Made the CHANGES and README files rdoc friendly.

== 0.1.0 - 12-Aug-2004
* Modified to use the newer allocation framework.  That means that, as of
  this release, this package requires Ruby 1.8.0 or later.
* Moved sample programs under doc/examples.

== 0.0.2 - 14-Mar-2004
* Fixed sprintf() bug in new().

== 0.0.1 - 13-Mar-2004
* Initial (Beta) release