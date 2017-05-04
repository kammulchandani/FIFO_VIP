`ifdef 9_7 
  `define   WIDTH    9
  `define   DEPTH    8
`elsif 9_275
  `define   WIDTH    9
  `define   DEPTH    276
`elsif 32_188
  `define   WIDTH    32
  `define   DEPTH    189
`elsif 32_275
  `define   WIDTH    32
  `define   DEPTH    276
`elsif 167_7
  `define   WIDTH    167
  `define   DEPTH    8
`elsif 167_188
  `define   WIDTH    167
  `define   DEPTH    189
`elsif 167_275
  `define   WIDTH    167
  `define   DEPTH    276
`else   
  `define   WIDTH    32
  `define   DEPTH    32 
`endif 

