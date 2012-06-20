CodeExport
==========

The CodeExport component facilitates automatic export of all methods in the host database to text files on disk.  If the host database is under revision control, these text files are suitable for committing to the repository, thus giving the developer to ability to track changes to methods over time. Most importantly, the CodeExport component is designed to have zero impact on the host database.  There is no startup code to install and nothing to configure.

The "components" folder contains the interpreted component suitable for installation in any 4D v13 database.

The "Plugins" folder contains the required plug-in Misc I for the component to function (from: http://sources.4d.com/trac/4d_keisuke/wiki/Plugins/MISC%20I)

The "matrix" folder contains the component source code.

The "doc" folder contains documentation about the component.

If you modify the matrix database, you should build a new component.  To build a new component, execute the CE_BLD_Build method from the matrix database.
