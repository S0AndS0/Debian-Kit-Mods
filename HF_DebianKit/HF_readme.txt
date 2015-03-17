Files contained here should be moved to;
	/data/local/deb/
directory.

File permissions should be set such that;
bootdeb-mod 	= 0775 	owned by shell
deb-mod 		= 0755 	owned by root
mk-debian-mod 	= 0775 	owned by shell
and then run with super user Android permissions;
	su && /data/local/deb/mk-debian-mod -h
to find new options.


