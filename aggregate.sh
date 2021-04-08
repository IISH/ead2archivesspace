#!/bin/bash

echo 'ARCHIEF,cxx_unittitle,lb_in_unittitle,count_physdesc_extent_item_encodinganalog_300a,count_physdesc_extent_bytes_encodinganalog_300a,cxx_geen_atribuut_level,physdesc_extent_kommagetal,odd_in_odd,langusage_language'

for xml in folder_uit/*.xml
do
  f=$(basename "$xml") && echo -n "${f:0:9}"
	echo -n "," && cat "${xml}" && echo ""
done
