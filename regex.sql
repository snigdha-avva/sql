use dec12;

select regexp_substr('1223abc',('[0-9]+'))
select regexp_substr('1223abc',('[0-9]'))

select regexp_substr('abc123gef',('[0-9]+'))

select regexp_substr('abcgef123',('[0-9]+'))

select regexp_substr('abc123gef456',('[0-9]+')) -- 123

select regexp_substr('abcgef123',('^[0-9]+'))

select regexp_substr('654abcgef123',('^[0-9]+'))

select regexp_substr('654abcgef123',('[0-9]+$'))

select regexp_substr('654abcgef123',('[0-9]{2}$'))

select regexp_substr('abc654gef123',('\\d{2}$'))

select regexp_substr('abc654gef123',('[0-9A-Z]+'))

select regexp_substr('snigdha@gmail.com',('@[a-z]+')) -- gmail

select regexp_substr('snigdha@gmail.com',('@[a-z.]+'))

select regexp_substr('snigdha@gmail.com',('[a-z.]+$'))

select replace(regexp_substr('snigdha@gmail.com',('@[a-z.]+')),"@","")

select regexp_substr('91-9999999999',('[0-9]+'))

select regexp_substr('91-9999999999',('-[0-9]+'))

select replace(regexp_substr('91-9999999999',('-[0-9]+')),"-","")