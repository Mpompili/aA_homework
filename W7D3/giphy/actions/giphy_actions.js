import * as APIUtil from '../util/api_util';

export const RECEIVE_SEARCH_GIPHYS = 'RECEIVE_SEARCH_GIPHYS';
export const REQUEST_SEARCH_GIPHYS = 'REQUEST_SEARCH_GIPHYS';

export const receiveSearchGiphys = giphys => {
  return {
    type: RECEIVE_SEARCH_GIPHYS,
    giphys
  }
};

export const fetchSearchGiphys = (searchTerm) => (dispatch) => {
  APIUtil.fetchSearchGiphys()
  .then(giphys => dispatch(receiveSearchGiphys(giphys.data)));
};

//when the fetchSearchGiphys action creator gets called with a search term, wants to return
// a function that can be called with dispatch, dispatch then sends a call back
// to fetchSearchGiphys() in APIUtil...which returns a promise...which when returned..
// uses the dispatch passed down to return the appropriate action from receiveSearchGiphys
