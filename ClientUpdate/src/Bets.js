import React, {Component} from 'react';
import Accordion from '@material-ui/core/Accordion';
import AccordionSummary from '@material-ui/core/AccordionSummary';
import AccordionDetails from '@material-ui/core/AccordionDetails';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import Container from '@material-ui/core/Container'
import Typography from '@material-ui/core/Typography'
import Button from '@material-ui/core/Button'
import {List, ListItem,CardMedia} from '@material-ui/core'

const months = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC']

function returnFormattedTime(unix) {
  var date = new Date(unix*1000)
  var day = date.getDate()
  var month = months[date.getMonth()]
  var year = date.getFullYear()
  var hours = date.getHours()
  var mins = date.getMinutes()
  var secs = date.getSeconds()
  return day+" "+month+" "+year+" "+hours+":"+mins+":"+secs+" (UTC)"
}


class BetCard extends Component {
  constructor(props) {
    super()
  }

  render() {
    var eventData = this.props.state.eventData[this.props.id]
    console.log(eventData)
    return(
      <div>
      <Typography>{eventData.description}</Typography>
      <List>
      {
        eventData.options.map((option,key) => {
          return(
            <ListItem button>{eventData.options[key]}: {eventData.price[key]}   [10 shares owned]</ListItem>
          )
        })
      }
      </List>
      <Typography>Betting finishes: {returnFormattedTime(eventData.endTime)}</Typography>
      <Typography>Answer revealed: {returnFormattedTime(eventData.resultTime)}</Typography>
      <Button>Set Outcome (only GAMEMASTER)</Button>
      <Button>Dispute Answer</Button>
      <Button size="large" color="primary" size="large" color="primary" variant="contained">Claim reward </Button>
      </div>
    )
  }
}

const bets=['test1','test2']

class Bets extends Component {
  constructor(props) {
    super()
  }

  render() {
    var bets = []
    for(var i=0;i<this.props.state.numberOfBets;i++) {
      bets.push('Bet '+i)
    }
    return(
      <Container>
      <Typography variant="h3">Markets</Typography>
      <CardMedia style={{ height: "150px" }} image="/market2.jpg" />
      <div>
      {
        bets.map((bet,key) => {
          return(
            <Accordion>
              <AccordionSummary expandIcon={<ExpandMoreIcon />}> {this.props.state.matchdata.title} </AccordionSummary>
              <AccordionDetails> <BetCard id={key} state={this.props.state} /> </AccordionDetails>
            </Accordion>
          )
        })
      }
      </div>
      </Container>
    )
  }
}

export default Bets
