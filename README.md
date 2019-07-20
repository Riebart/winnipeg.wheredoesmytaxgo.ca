# winnipeg.wheredoesmytaxgo.ca

An itty bitty little proof of concept that uses public data sources to calculate tax allocation by department, in dollars per year. This is based on the input address, and assumes a residential property; it pulls the mill rates, portions, tax-supported budget per department, and latest assessed property value, and computes the result (in dollars per year).

For now, this is a proof that it works and is doable without privileged data, but eventually I'd like a small website to automate it and make it easy.

Example:

```bash
$ bash calculate.sh "744 Garfield"
{
    "Police_Service": 391,
    "Fire_Service": 188,
    "Road_Maintenance": 115,
    "Public_Transit": 105,
    "Organizational_Support_Service": 66,
    "Recreation": 64,
    "Parks_and_Urban_Forestry": 53,
    "Roadway_Snow_Removal_and_Ice_Clearing": 53,
    "Libraries": 44,
    "Solid_Waste_Collection": 33,
    "City_Beautification": 26,
    "Council_Services": 20,
    "Street_Lighting*": 20,
    "Assiniboine_Park_Conservancy": 20,
    "Medical_Response": 17,
    "Remaining_Arts,_Ent_&_Culture": 12,
    "Insect_Control": 11,
    "Assessment_and_Taxation": 10,
    "311_Contact_Centre": 7,
    "Community_Liveability": 6,
    "Economic_Development": 2,
    "Animal_Services": 2,
    "City_Planning,_Insp_&_Housing": 2,
    "Cemeteries": 1,
    "Golf_Services": 1
}

real    0m1.621s
user    0m0.141s
sys     0m0.516s
```
