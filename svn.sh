cd /dspace
svn up
svn add assetstore --force
pg_dump dspace > contest
svn ci -m "update" 

