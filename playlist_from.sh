#/bin/sh
filename=$1
output=$2
if [[ -z "$output" ]]; then 
  output=./playlist.xspf
fi
if test -f $output; then
  rm $output
fi
touch playlist.xspf
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<playlist xmlns=\"http://xspf.org/ns/0/\" xmlns:vlc=\"http://www.videolan.org/vlc/playlist/ns/0/\" version=\"1\">
	<title>Playlist</title>
	<trackList>" >> $output;

idx=0
while IFS= read -r line
do
  if [ $((idx%2)) -eq 0 ]; then
	  echo $(echo "<track><title>$line</title>" | tr -d '\n') >> $output
  else
    echo $(echo "<location>$line</location></track>"  | tr -d '\n') >> $output
  fi
  (( idx++ ))
done < "$filename"

echo "	</trackList>
</playlist>" >> $output