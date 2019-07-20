# winnipeg.wheredoesmytaxgo.ca

An itty bitty little proof of concept that uses public data sources to calculate tax allocation by department, in dollars per year. This is based on the input address, and assumes a residential property; it pulls the mill rates, portions, tax-supported budget per department, and latest assessed property value, and computes the result (in dollars per year).

For now, this is a proof that it works and is doable without privileged data, but eventually I'd like a small website to automate it and make it easy.

Example:

```bash
$ time bash calculate.sh "744 Garfield" | jq .
{
    "Police Service": 391,
    "Fire Service": 188,
    "Road Maintenance": 115,
    "Public Transit": 105,
    "Organizational Support Service": 66,
    "Recreation": 64,
    "Parks and Urban Forestry": 53,
    "Roadway Snow Removal and Ice Clearing": 53,
    "Libraries": 44,
    "Solid Waste Collection": 33,
    "City Beautification": 26,
    "Council Services": 20,
    "Street Lighting*": 20,
    "Assiniboine Park Conservancy": 20,
    "Medical Response": 17,
    "Remaining Arts, Ent & Culture": 12,
    "Insect Control": 11,
    "Assessment and Taxation": 10,
    "311 Contact Centre": 7,
    "Community Liveability": 6,
    "Economic Development": 2,
    "Animal Services": 2,
    "City Planning, Insp & Housing": 2,
    "Cemeteries": 1,
    "Golf Services": 1
}

real    0m1.621s
user    0m0.141s
sys     0m0.516s
```
