# vending machine
a simple vhdl code for a ticket vending machine processor.

## List of items:
| Name     | Describtion | Cost |
| ---      | ---       | ---    |
| ticket0 | one-way ticket | 500$ |
| ticket1 | one day ticket | 1500$ |
| ticket2 | one weak ticket | 4000$ |

## List of coins:
| Name     |  Value |
| ---      |  ---    |
| coin5 | 500$ |
| coin10 | 1000$ |

## Inputs:
| Name     | Describtion |
| ---      | ---       |
| reset | to restart the machine         |
| ticket_sensor0     | sensor for ticket0 button        |
| ticket_sensor1     | sensor for ticket1 button        |
| ticket_sensor1     | sensor for ticket1 button        |
| coin5_sensor     | sensor for coin5        |
| coin10_sensor     | sensor for coin10        |
| finsih     | completing the operation        |

## Outputs:
| Name     | Describtion |
| ---      | ---       |
| publish_ticket0     | publishing ticket0    |
| publish_ticket1     | publishing ticket1    |
| publish_ticket2     | publishing ticket2    |
| return_coin5     | return a coin5 to user   |
| return_coin10     | return a coin10 to user   |
| balance_not_enough     | warn the user that balance is not enough   |
 


