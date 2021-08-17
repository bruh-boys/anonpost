mix deps.get


cd public/TS
tsc --build tsconfig.json
cd ..
sass  scss:css
cd ..
