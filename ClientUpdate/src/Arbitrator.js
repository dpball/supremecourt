import React, {Component} from 'react';
import Accordion from '@material-ui/core/Accordion';
import AccordionSummary from '@material-ui/core/AccordionSummary';
import AccordionDetails from '@material-ui/core/AccordionDetails';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import Container from '@material-ui/core/Container'
import Typography from '@material-ui/core/Typography'
import Button from '@material-ui/core/Button'
import {List, ListItem} from '@material-ui/core'

class DisputeCard extends Component {
  constructor(props) {
    super()
  }

  render() {
    return(
      <div>
      <Typography>{this.props.state.matchdata.title}</Typography>
      <Typography>{this.props.state.matchdata.description}</Typography>
      <Typography> User claimed the outcome is [X] whilst user has disputed this</Typography>
      <Typography>{this.props.state.matchdata.question}</Typography>
      <List>
      {this.props.state.matchdata.rulingOptions.descriptions.map((description,key) => {
        return(
        <ListItem button>{description}</ListItem>
      )
      })}
      <ListItem button>Refuse to Arbitrate</ListItem>
      </List>
      </div>
    )
  }
}

const disputes =['Dispute 1','Dispute 2']

class Arbitrator extends Component {
  constructor(props) {
    super()
  }

  render() {
    return(
      <Container>
      <Typography variant="h3"> Test Arbitrator </Typography>
      <div>
      {
        disputes.map((dispute,key) => {
          return(
            <Accordion>
              <AccordionSummary expandIcon={<ExpandMoreIcon />}> {dispute} </AccordionSummary>
              <AccordionDetails> <DisputeCard state={this.props.state}/> </AccordionDetails>
            </Accordion>
          )
        })
      }
      </div>
      </Container>
    )
  }
}

export default Arbitrator
