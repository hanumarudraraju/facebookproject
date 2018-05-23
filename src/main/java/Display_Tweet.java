

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class Display_Tweet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		try {
		
		String id="";
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		
		if (req.getParameterMap().containsKey("id")) {		

			id = req.getParameter("id");
			Key tweetKey = KeyFactory.createKey("Tweet", id);
			Entity tweet = ds.get(tweetKey);
			tweet.setProperty("visited", Integer.parseInt(tweet.getProperty("visited").toString())+1);
			ds.put(tweet);

			req.setAttribute("ID", id);
			req.setAttribute("msg", tweet.getProperty("msg").toString());
			req.setAttribute("msgDate", tweet.getProperty("msgDate").toString());
			req.setAttribute("sender", tweet.getProperty("sender").toString());
			req.setAttribute("visited", tweet.getProperty("visited").toString());
		}

		resp.setContentType("text/html");

        RequestDispatcher jsp = req.getRequestDispatcher("/WEB-INF/display_tweet.jsp");
        jsp.forward(req, resp);
        
		} catch (EntityNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		doGet(req,resp);
	}

}
