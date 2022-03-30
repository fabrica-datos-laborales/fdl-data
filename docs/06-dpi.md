

# DPI
<table class="table" style="font-size: 10px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Variable </th>
   <th style="text-align:left;"> Concept </th>
   <th style="text-align:left;"> Definition </th>
   <th style="text-align:left;"> Values </th>
   <th style="text-align:left;"> Class </th>
   
  </tr>
 </thead>
<tbody>
  <tr grouplength="11"><td colspan="6" style="border-bottom: 1px solid;"><strong>Democracy and Sociopolitical System</strong></td></tr>
<tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> elec_sys_dpi </td>
   <td style="text-align:left;"> Electoral system </td>
   <td style="text-align:left;"> Whether the country's political system is parlamentary (2), assembly-elected president (1), or presidential (0). Systems with unelected executives get a (0). Systems with presidents who are elected directly or by an electoral college (whose only function is to elect the president), in cases where there is no prime minister, also receive a (0). Countries in which the legislature elects the chief executive are parlamientary (2), with the following exception: if that assembly or group cannot easily recall him, then the system gets a (1). </td>
   <td style="text-align:left;"> 0= Presidential , 1= Assembly-elected president, 2= Parlamentary </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> if_military_dpi </td>
   <td style="text-align:left;"> Military officer Chief Executive </td>
   <td style="text-align:left;"> Whether the Chief Executive is a military officer (1) or not (0). (1) if the source (Europa or Banks) includes a rank in their title, (0) otherwise. If chief executives were described as officers with no indication of formal retirement when they assumed office, they are always listed as officers for the duration of their term. If chief executives were formally retired military officers upon taking office, then this variable gets a (0). </td>
   <td style="text-align:left;"> 1 = Yes, 2 = No </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> exec_party_dpi </td>
   <td style="text-align:left;"> Party of Chief Executive </td>
   <td style="text-align:left;"> Name of the party of chief executive, if any. "Independent" if the chief executive is independent, a monarch, in the military, or if these are no parties. </td>
   <td style="text-align:left;"> Party's name </td>
   <td style="text-align:left;"> character </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> exec_party_or_dpi </td>
   <td style="text-align:left;"> Executive's party political orientation </td>
   <td style="text-align:left;"> Party orientation with respect to economic policy, using the following criteria: (1) Right: for parties that are defined as conservative, Christian democratic, or right-wing. (2) Center: for parties that are defined as centrist or when party position can best be described as centrist. (3) Left: for parties that are defined as communist, socialist, social democratic, or left-wing. (0) For all those cases which do not fit into the above-mentioned category, or no information. (NA) for those cases which there is no executive. </td>
   <td style="text-align:left;"> 0= no information or no category to fit in, 1= right, 2= center, 3= left </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> exec_party_rel_dpi </td>
   <td style="text-align:left;"> Executive's party religion </td>
   <td style="text-align:left;"> If the executive chief's party is religious, whether (1) Christian, (2) Catholic, (3) Islamic, (4) Hindu, (5) Buddhist, (6) Jewish, (0) otherwise. All parties that are called Christian-Democratic by one of our sources are listed as "Christian". "Islamic" only recorded if 1) The chief executive is also a religious leader, and 2) That religion is Islam. In all other cases, platform and constituency are main indicators. In cases where executive is independent, the executive's personal orientation is recorded. (NA) if no executive. </td>
   <td style="text-align:left;"> 0= Otherwise, 1= Christian, 2= Catholic, 3= Islamic, 4= Hindu, 5= Buddhist, 6= Jewish </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> exec_party_maj_dpi </td>
   <td style="text-align:left;"> Executive's party majority </td>
   <td style="text-align:left;"> If the party of the executive have an absolute majority in the houses that have lawmaking powers. (1) Yes, (2) no. </td>
   <td style="text-align:left;"> 1 = Yes, 2 = No </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> oppo_party_sen_dpi </td>
   <td style="text-align:left;"> Opposition majority in senate </td>
   <td style="text-align:left;"> Wheter one opposition party has an absolute majority in Senate (1) or not (2). </td>
   <td style="text-align:left;"> 1 = Yes, 2 = No </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> oppo_party_h_dpi </td>
   <td style="text-align:left;"> Opposition majority in house </td>
   <td style="text-align:left;"> Wheter one opposition party has an absolute majority in House (1) or not (2). </td>
   <td style="text-align:left;"> 1 = Yes, 2 = No </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> plural_dpi </td>
   <td style="text-align:left;"> Plurality electionary system </td>
   <td style="text-align:left;"> Whether there is a "plurality" system (1) or not (0). In "plurality" systems, legislatores are elected using a winner-take-all/first past the pole rule. (1) if there is a competition for the seats in a one-party-state, blank if it is unclear whether there is competition for seats in a one-party state, and (NA) if there is no competition for seats in a one-party state or if legislators are appointed. </td>
   <td style="text-align:left;"> 1 = Yes, 2 = No </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> prop_dpi </td>
   <td style="text-align:left;"> Proportional representation electionary system </td>
   <td style="text-align:left;"> Whether there is a "proportional representation" system (1) or not (0). (1) if candidates are elected based on the percent of votes received by their party and/or if our sources specifically call the system "proportional representation". </td>
   <td style="text-align:left;"> 1 = Yes, 2 = No </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
  <tr>
   <td style="text-align:left;padding-left: 2em;" indentlevel="1"> dhondt_dpi </td>
   <td style="text-align:left;"> D'Hondt electionary system </td>
   <td style="text-align:left;"> Whether the D'Hondt system is used (1) or not (0). </td>
   <td style="text-align:left;"> 1 = Yes, 2 = No </td>
   <td style="text-align:left;"> factor </td>
   
  </tr>
</tbody>
</table>

