from UnifiedCore import create_app, db
from UnifiedCore.models import Results
app = create_app()
import pprint
with app.app_context():
	x = Results.query.first()
	pprint.pprint({
		'student_name':x.student_name,
		'term':x.term_name,
		'year':x.year})
	y = Results.query.filter_by(year=x.year, term_name=x.term_name, student_name=x.student_name).first()
	pprint.pprint({
		'source':'query',
		'student_name':y.student_name,
                'term':y.term_name,
                'year':y.year})
