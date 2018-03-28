import { RECEIVE_SEARCH_GIPHYS } from '../actions/giphy_actions';

const giphysReducer = (state = [], action) => {
  let newState;
  switch (action.type) {
    case RECEIVE_SEARCH_GIPHYS:
      return action.giphy;
    default:
      return state;
  }
}

export default giphysReducer;
